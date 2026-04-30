// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// Otomatik tetikleme mekanizması (timeout) için Chainlink Automation arayüzü
import "@chainlink/contracts/src/v0.8/automation/AutomationCompatible.sol";

/**
 * @title DecentralizedReservation
 * @dev Gamze Nur Polat - Görev 2: Merkeziyetsiz Altyapı
 * Bu akıllı kontrat, rezervasyonların adil ve değiştirilemez bir şekilde saklanmasını
 * ve "Rezerve" durumundan 15 dakika sonra otomatik olarak boşa çıkmasını sağlar.
 */
contract DecentralizedReservation is AutomationCompatibleInterface {
    
    // Masanın alabileceği durumlar
    enum TableStatus { Available, Reserved, Occupied }

    // Masa verisi için yapı (Struct)
    struct Table {
        uint256 id;
        TableStatus status;
        address reserver;
        uint256 reservationTime;
    }

    // Masaları ID'lerine göre saklayan harita
    mapping(uint256 => Table) public tables;
    uint256 public totalTables;
    
    // 15 Dakikalık zaman aşımı süresi
    uint256 public constant TIMEOUT = 15 minutes;

    // Otomasyon (Keeper) için hızlıca kontrol edilebilecek ayrılmış masalar listesi
    uint256[] public reservedTableIds;

    address public admin;

    // Olaylar (Events) - Şeffaflık ve işlem kayıtları için
    event ReservationMade(uint256 indexed tableId, address indexed reserver, uint256 timestamp);
    event TableVerified(uint256 indexed tableId, address indexed reserver, uint256 timestamp);
    event ReservationTimeout(uint256 indexed tableId, address indexed reserver, uint256 timestamp);
    event TableFreed(uint256 indexed tableId, uint256 timestamp);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Not admin");
        _;
    }

    /**
     * @dev Sisteme başlangıçta kaç masa olacağını belirterek başlar.
     */
    constructor(uint256 _totalTables) {
        admin = msg.sender;
        totalTables = _totalTables;
        for (uint256 i = 1; i <= _totalTables; i++) {
            tables[i] = Table({
                id: i,
                status: TableStatus.Available,
                reserver: address(0),
                reservationTime: 0
            });
        }
    }

    /**
     * @dev Masa rezerve etme işlemi.
     * Masanın "Available" (Uygun) olması gerekir.
     */
    function reserveTable(uint256 _tableId) external {
        require(_tableId > 0 && _tableId <= totalTables, "Invalid table ID");
        Table storage t = tables[_tableId];
        
        // Sadece uygun masalar rezerve edilebilir
        require(t.status == TableStatus.Available, "Table not available");

        t.status = TableStatus.Reserved;
        t.reserver = msg.sender;
        t.reservationTime = block.timestamp;

        reservedTableIds.push(_tableId);

        emit ReservationMade(_tableId, msg.sender, block.timestamp);
    }

    /**
     * @dev Fiziksel doğrulama işlemi. (Masaya geçildiğinde çağrılır)
     * Kullanıcı veya yetkili cihaz (admin) çağırabilir.
     * 15 dakika dolmadan çağrılmalıdır.
     */
    function verifyPresence(uint256 _tableId) external {
        Table storage t = tables[_tableId];
        require(t.status == TableStatus.Reserved, "Table not reserved");
        require(msg.sender == t.reserver || msg.sender == admin, "Not authorized");
        require(block.timestamp <= t.reservationTime + TIMEOUT, "Reservation expired");

        t.status = TableStatus.Occupied;
        
        _removeFromReservedList(_tableId);

        emit TableVerified(_tableId, t.reserver, block.timestamp);
    }

    /**
     * @dev Masa kullanımını bitirip boşa çıkarma işlemi.
     */
    function freeTable(uint256 _tableId) external {
        Table storage t = tables[_tableId];
        require(t.status == TableStatus.Occupied, "Table not occupied");
        require(msg.sender == t.reserver || msg.sender == admin, "Not authorized");

        t.status = TableStatus.Available;
        t.reserver = address(0);
        t.reservationTime = 0;

        emit TableFreed(_tableId, block.timestamp);
    }

    // ---------------------------------------------------------------- //
    // --- OTOMATİK TETİKLEYİCİ SİSTEMİ (CHAINLINK KEEPERS) MEKANİZMASI ---
    // ---------------------------------------------------------------- //

    /**
     * @dev Zaman aşımına (15 dk) uğrayan masa var mı diye off-chain (zincir dışı) kontrol eden metod.
     */
    function checkUpkeep(bytes calldata /* checkData */) 
        external 
        view 
        override 
        returns (bool upkeepNeeded, bytes memory performData) 
    {
        uint256[] memory expiredTables = new uint256[](reservedTableIds.length);
        uint256 count = 0;

        for (uint256 i = 0; i < reservedTableIds.length; i++) {
            uint256 tId = reservedTableIds[i];
            Table memory t = tables[tId];
            
            // Eğer masa rezerve edilmişse ve rezervasyon zamanından itibaren 15 dk geçmişse
            if (t.status == TableStatus.Reserved && block.timestamp > t.reservationTime + TIMEOUT) {
                expiredTables[count] = tId;
                count++;
            }
        }

        if (count > 0) {
            upkeepNeeded = true;
            uint256[] memory performIds = new uint256[](count);
            for (uint256 i = 0; i < count; i++) {
                performIds[i] = expiredTables[i];
            }
            performData = abi.encode(performIds); // İptal edilecek masaların ID'lerini yolla
        }
    }

    /**
     * @dev Zaman aşımına uğramış masaları zincir üstünde (on-chain) serbest bırakan otomatik çalıştırılacak metod.
     */
    function performUpkeep(bytes calldata performData) external override {
        uint256[] memory performIds = abi.decode(performData, (uint256[]));
        
        for (uint256 i = 0; i < performIds.length; i++) {
            uint256 tId = performIds[i];
            Table storage t = tables[tId];
            
            // Ek güvenlik önlemi: Tekrar kontrol et (15 dk geçmiş mi?)
            if (t.status == TableStatus.Reserved && block.timestamp > t.reservationTime + TIMEOUT) {
                address oldReserver = t.reserver;
                
                // Masayı diğer kullanıcılara aç (Available)
                t.status = TableStatus.Available;
                t.reserver = address(0);
                t.reservationTime = 0;

                _removeFromReservedList(tId);

                emit ReservationTimeout(tId, oldReserver, block.timestamp);
            }
        }
    }

    /**
     * @dev Otomasyon sırasında süresi dolmuş veya doğrulanmış masaları işlem listesinden çıkarmak için yardımcı metod.
     */
    function _removeFromReservedList(uint256 _tableId) internal {
        for (uint256 i = 0; i < reservedTableIds.length; i++) {
            if (reservedTableIds[i] == _tableId) {
                reservedTableIds[i] = reservedTableIds[reservedTableIds.length - 1];
                reservedTableIds.pop();
                break;
            }
        }
    }
}
