-- =========================================================
-- 1. TABLOLAR
-- =========================================================

-- 1.1 Roller
CREATE TABLE roller (
    rol_id SERIAL PRIMARY KEY,
    rol_adi VARCHAR(50) UNIQUE NOT NULL
);

-- 1.2 Kullanicilar
CREATE TABLE kullanicilar (
    kullanici_id SERIAL PRIMARY KEY,
    rol_id INT NOT NULL,
    ogrenci_no VARCHAR(30) UNIQUE NOT NULL,
    ad_soyad VARCHAR(100) NOT NULL,
    email VARCHAR(120) UNIQUE NOT NULL,
    sifre_hash TEXT NOT NULL,
    telefon_no VARCHAR(20),
    aktif_mi BOOLEAN DEFAULT TRUE,
    olusturma_tarihi TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (rol_id) REFERENCES roller(rol_id)
);

-- 1.3 Dijital Kimlikler / NFC
CREATE TABLE dijital_kimlikler (
    kimlik_id SERIAL PRIMARY KEY,
    kullanici_id INT UNIQUE NOT NULL,
    nfc_uid VARCHAR(100) UNIQUE NOT NULL,
    aktif_mi BOOLEAN DEFAULT TRUE,
    olusturma_tarihi TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (kullanici_id) REFERENCES kullanicilar(kullanici_id)
        ON DELETE CASCADE
);

-- 1.4 Kutuphane Alanlari
CREATE TABLE alanlar (
    alan_id SERIAL PRIMARY KEY,
    alan_adi VARCHAR(100) NOT NULL,
    alan_tipi VARCHAR(30) NOT NULL
        CHECK (alan_tipi IN ('normal', 'okuma', 'bilgisayar', '724')),
    kat_no INT,
    acilis_saati TIME,
    kapanis_saati TIME,
    yedi_yirmi_dort BOOLEAN DEFAULT FALSE
);

-- 1.5 Masalar
CREATE TABLE masalar (
    masa_id SERIAL PRIMARY KEY,
    alan_id INT NOT NULL,
    masa_no VARCHAR(30) UNIQUE NOT NULL,
    kapasite INT DEFAULT 1,
    durum VARCHAR(20) DEFAULT 'bos'
        CHECK (durum IN ('bos', 'rezerve', 'dolu')),
    olusturma_tarihi TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (alan_id) REFERENCES alanlar(alan_id)
        ON DELETE CASCADE
);

-- 1.6 Masa QR Kodlari
CREATE TABLE masa_qr_kodlari (
    qr_id SERIAL PRIMARY KEY,
    masa_id INT UNIQUE NOT NULL,
    qr_kod VARCHAR(150) UNIQUE NOT NULL,
    aktif_mi BOOLEAN DEFAULT TRUE,
    olusturma_tarihi TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (masa_id) REFERENCES masalar(masa_id)
        ON DELETE CASCADE
);

-- 1.7 Rezervasyonlar
CREATE TABLE rezervasyonlar (
    rezervasyon_id SERIAL PRIMARY KEY,
    kullanici_id INT NOT NULL,
    masa_id INT NOT NULL,
    baslangic_zamani TIMESTAMP NOT NULL,
    bitis_zamani TIMESTAMP NOT NULL,
    durum VARCHAR(20) DEFAULT 'beklemede'
        CHECK (durum IN ('beklemede', 'aktif', 'tamamlandi', 'iptal', 'sure_asimi')),
    olusturma_tarihi TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (kullanici_id) REFERENCES kullanicilar(kullanici_id)
        ON DELETE CASCADE,

    FOREIGN KEY (masa_id) REFERENCES masalar(masa_id)
        ON DELETE CASCADE,

    CHECK (bitis_zamani > baslangic_zamani)
);

-- 1.8 NFC Giris Kayitlari
CREATE TABLE nfc_giris_kayitlari (
    giris_id SERIAL PRIMARY KEY,
    kullanici_id INT NOT NULL,
    nfc_uid VARCHAR(100) NOT NULL,
    giris_zamani TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    durum VARCHAR(20) DEFAULT 'onaylandi'
        CHECK (durum IN ('onaylandi', 'reddedildi')),

    FOREIGN KEY (kullanici_id) REFERENCES kullanicilar(kullanici_id)
        ON DELETE CASCADE
);

-- 1.9 QR Kontrol Kayitlari
CREATE TABLE qr_kontrol_kayitlari (
    kontrol_id SERIAL PRIMARY KEY,
    rezervasyon_id INT NOT NULL,
    kullanici_id INT NOT NULL,
    masa_id INT NOT NULL,
    qr_kod VARCHAR(150) NOT NULL,
    kontrol_zamani TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    durum VARCHAR(20) DEFAULT 'basarili'
        CHECK (durum IN ('basarili', 'basarisiz')),

    FOREIGN KEY (rezervasyon_id) REFERENCES rezervasyonlar(rezervasyon_id)
        ON DELETE CASCADE,

    FOREIGN KEY (kullanici_id) REFERENCES kullanicilar(kullanici_id)
        ON DELETE CASCADE,

    FOREIGN KEY (masa_id) REFERENCES masalar(masa_id)
        ON DELETE CASCADE
);

-- 1.10 Rezervasyon Gecmisi
CREATE TABLE rezervasyon_gecmisi (
    gecmis_id SERIAL PRIMARY KEY,
    rezervasyon_id INT NOT NULL,
    eski_durum VARCHAR(20),
    yeni_durum VARCHAR(20),
    aciklama TEXT,
    degisim_tarihi TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (rezervasyon_id) REFERENCES rezervasyonlar(rezervasyon_id)
        ON DELETE CASCADE
);

-- 1.11 Aktivite Loglari
CREATE TABLE aktivite_loglari (
    log_id SERIAL PRIMARY KEY,
    kullanici_id INT,
    islem_tipi VARCHAR(80) NOT NULL,
    aciklama TEXT,
    tarih TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (kullanici_id) REFERENCES kullanicilar(kullanici_id)
        ON DELETE SET NULL
);

-- 1.12 Raporlar
CREATE TABLE raporlar (
    rapor_id SERIAL PRIMARY KEY,
    rapor_tipi VARCHAR(80) NOT NULL,
    rapor_tarihi DATE DEFAULT CURRENT_DATE,
    toplam_rezervasyon INT DEFAULT 0,
    toplam_checkin INT DEFAULT 0,
    doluluk_orani NUMERIC(5,2),
    en_yogun_saat VARCHAR(20),
    olusturma_tarihi TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 1.13 Ceza Kayitlari
CREATE TABLE ceza_kayitlari (
    ceza_id SERIAL PRIMARY KEY,
    kullanici_id INT NOT NULL,
    rezervasyon_id INT,
    ceza_nedeni TEXT NOT NULL,
    ceza_baslangic TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ceza_bitis TIMESTAMP NOT NULL,
    aktif_mi BOOLEAN DEFAULT TRUE,

    FOREIGN KEY (kullanici_id) REFERENCES kullanicilar(kullanici_id)
        ON DELETE CASCADE,

    FOREIGN KEY (rezervasyon_id) REFERENCES rezervasyonlar(rezervasyon_id)
        ON DELETE SET NULL
);

-- =========================================================
-- 2. SEED DATA / ORNEK VERILER
-- =========================================================

INSERT INTO roller (rol_adi) VALUES
('ogrenci'),
('yonetici');

INSERT INTO kullanicilar (rol_id, ogrenci_no, ad_soyad, email, sifre_hash, telefon_no)
VALUES
(1, '20240001', 'Ayse Yilmaz', 'ayse.yilmaz@ogrenci.edu.tr', 'hash_ayse123', '05551112233'),
(1, '20240002', 'Mehmet Demir', 'mehmet.demir@ogrenci.edu.tr', 'hash_mehmet123', '05552223344'),
(1, '20240003', 'Zeynep Kaya', 'zeynep.kaya@ogrenci.edu.tr', 'hash_zeynep123', '05553334455'),
(2, 'ADMIN001', 'Kutuphane Yoneticisi', 'yonetici@kutuphane.edu.tr', 'hash_admin123', '05554445566');

INSERT INTO dijital_kimlikler (kullanici_id, nfc_uid)
VALUES
(1, 'NFC-AYSE-001'),
(2, 'NFC-MEHMET-002'),
(3, 'NFC-ZEYNEP-003'),
(4, 'NFC-ADMIN-004');

INSERT INTO alanlar (alan_adi, alan_tipi, kat_no, acilis_saati, kapanis_saati, yedi_yirmi_dort)
VALUES
('Okuma Alani', 'okuma', 0, '08:00', '23:00', FALSE),
('7/24 Calisma Alani', '724', 1, NULL, NULL, TRUE),
('Ust Kat Normal Alan', 'normal', 2, '08:00', '23:00', FALSE),
('Bilgisayar Alani', 'bilgisayar', 3, '08:00', '23:00', FALSE);

INSERT INTO masalar (alan_id, masa_no, kapasite, durum)
VALUES
(1, 'Masa-101', 1, 'bos'),
(1, 'Masa-102', 1, 'bos'),
(1, 'Masa-103', 1, 'bos'),
(2, 'Masa-201', 1, 'bos'),
(2, 'Masa-202', 1, 'bos'),
(3, 'Masa-301', 1, 'bos'),
(3, 'Masa-302', 1, 'bos'),
(4, 'Masa-401', 1, 'bos');

INSERT INTO masa_qr_kodlari (masa_id, qr_kod)
VALUES
(1, 'QR-MASA-101'),
(2, 'QR-MASA-102'),
(3, 'QR-MASA-103'),
(4, 'QR-MASA-201'),
(5, 'QR-MASA-202'),
(6, 'QR-MASA-301'),
(7, 'QR-MASA-302'),
(8, 'QR-MASA-401');

-- Ornek rezervasyonlar
INSERT INTO rezervasyonlar (kullanici_id, masa_id, baslangic_zamani, bitis_zamani, durum)
VALUES
(1, 1, '2026-04-29 10:00:00', '2026-04-29 12:00:00', 'beklemede'),
(2, 4, '2026-04-29 13:00:00', '2026-04-29 15:00:00', 'aktif'),
(3, 8, '2026-04-29 16:00:00', '2026-04-29 18:00:00', 'tamamlandi');

INSERT INTO nfc_giris_kayitlari (kullanici_id, nfc_uid, giris_zamani, durum)
VALUES
(1, 'NFC-AYSE-001', '2026-04-29 09:55:00', 'onaylandi'),
(2, 'NFC-MEHMET-002', '2026-04-29 12:50:00', 'onaylandi'),
(3, 'NFC-ZEYNEP-003', '2026-04-29 15:55:00', 'onaylandi');

INSERT INTO qr_kontrol_kayitlari (rezervasyon_id, kullanici_id, masa_id, qr_kod, kontrol_zamani, durum)
VALUES
(2, 2, 4, 'QR-MASA-201', '2026-04-29 13:02:00', 'basarili'),
(3, 3, 8, 'QR-MASA-401', '2026-04-29 16:01:00', 'basarili');

INSERT INTO rezervasyon_gecmisi (rezervasyon_id, eski_durum, yeni_durum, aciklama)
VALUES
(2, 'beklemede', 'aktif', 'Kullanici QR/NFC dogrulamasi yapti.'),
(3, 'aktif', 'tamamlandi', 'Rezervasyon suresi tamamlandi.');

INSERT INTO aktivite_loglari (kullanici_id, islem_tipi, aciklama)
VALUES
(1, 'rezervasyon_olusturma', 'Masa-101 icin rezervasyon olusturuldu.'),
(2, 'qr_nfc_dogrulama', 'Masa-201 icin QR/NFC dogrulamasi basarili.'),
(3, 'rezervasyon_tamamlama', 'Masa-401 rezervasyonu tamamlandi.');

INSERT INTO raporlar (rapor_tipi, toplam_rezervasyon, toplam_checkin, doluluk_orani, en_yogun_saat)
VALUES
('gunluk_kullanim', 3, 2, 25.00, '13:00-15:00');

-- =========================================================
-- 3. INDEXLER
-- =========================================================

CREATE INDEX idx_rezervasyon_masa_zaman
ON rezervasyonlar (masa_id, baslangic_zamani, bitis_zamani);

CREATE INDEX idx_rezervasyon_kullanici_durum
ON rezervasyonlar (kullanici_id, durum);

CREATE INDEX idx_qr_kod
ON masa_qr_kodlari (qr_kod);

CREATE INDEX idx_nfc_uid
ON dijital_kimlikler (nfc_uid);

CREATE INDEX idx_ceza_kullanici_aktif
ON ceza_kayitlari (kullanici_id, aktif_mi, ceza_bitis);

-- =========================================================
-- 4. FUNCTION / PROCEDURE MANTIGI
-- =========================================================

-- 4.1 Rezervasyon Olusturma
CREATE OR REPLACE FUNCTION rezervasyon_olustur(
    p_kullanici_id INT,
    p_masa_id INT,
    p_baslangic_zamani TIMESTAMP,
    p_bitis_zamani TIMESTAMP
)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
    v_rezervasyon_id INT;
    v_kullanici_aktif BOOLEAN;
    v_masa_durum VARCHAR(20);
    v_cakisan_rezervasyon_sayisi INT;

    v_acilis_saati TIME;
    v_kapanis_saati TIME;
    v_yedi_yirmi_dort BOOLEAN;
BEGIN
    -- Bitis zamani baslangictan sonra mi?
    IF p_bitis_zamani <= p_baslangic_zamani THEN
        RAISE EXCEPTION 'Bitis zamani baslangic zamanindan sonra olmalidir.';
    END IF;

    -- Kullanici aktif mi?
    SELECT aktif_mi
    INTO v_kullanici_aktif
    FROM kullanicilar
    WHERE kullanici_id = p_kullanici_id;

    IF v_kullanici_aktif IS NULL THEN
        RAISE EXCEPTION 'Kullanici bulunamadi.';
    END IF;

    IF v_kullanici_aktif = FALSE THEN
        RAISE EXCEPTION 'Kullanici aktif degil.';
    END IF;

    -- Aktif ceza var mi?
    IF EXISTS (
        SELECT 1
        FROM ceza_kayitlari
        WHERE kullanici_id = p_kullanici_id
          AND aktif_mi = TRUE
          AND ceza_bitis > CURRENT_TIMESTAMP
    ) THEN
        RAISE EXCEPTION 'Aktif cezaniz bulundugu icin rezervasyon olusturamazsiniz.';
    END IF;

    -- Masa ve alan bilgisi kontrolu
    SELECT m.durum, a.acilis_saati, a.kapanis_saati, a.yedi_yirmi_dort
    INTO v_masa_durum, v_acilis_saati, v_kapanis_saati, v_yedi_yirmi_dort
    FROM masalar m
    JOIN alanlar a ON m.alan_id = a.alan_id
    WHERE m.masa_id = p_masa_id;

    IF v_masa_durum IS NULL THEN
        RAISE EXCEPTION 'Masa bulunamadi.';
    END IF;

    IF v_masa_durum = 'dolu' THEN
        RAISE EXCEPTION 'Masa su anda dolu.';
    END IF;

    -- Alan 7/24 degilse calisma saati kontrolu yap
    IF v_yedi_yirmi_dort = FALSE THEN
        IF p_baslangic_zamani::TIME < v_acilis_saati
           OR p_bitis_zamani::TIME > v_kapanis_saati THEN
            RAISE EXCEPTION 'Secilen saat araligi bu alanin calisma saatleri disinda.';
        END IF;
    END IF;

    -- Ayni masada saat cakismasi var mi?
    SELECT COUNT(*)
    INTO v_cakisan_rezervasyon_sayisi
    FROM rezervasyonlar
    WHERE masa_id = p_masa_id
      AND durum IN ('beklemede', 'aktif')
      AND p_baslangic_zamani < bitis_zamani
      AND p_bitis_zamani > baslangic_zamani;

    IF v_cakisan_rezervasyon_sayisi > 0 THEN
        RAISE EXCEPTION 'Bu masa secilen saat araliginda uygun degil.';
    END IF;

    -- Rezervasyon olustur
    INSERT INTO rezervasyonlar (
        kullanici_id,
        masa_id,
        baslangic_zamani,
        bitis_zamani,
        durum
    )
    VALUES (
        p_kullanici_id,
        p_masa_id,
        p_baslangic_zamani,
        p_bitis_zamani,
        'beklemede'
    )
    RETURNING rezervasyon_id INTO v_rezervasyon_id;

    -- Aktivite logu
    INSERT INTO aktivite_loglari (
        kullanici_id,
        islem_tipi,
        aciklama
    )
    VALUES (
        p_kullanici_id,
        'rezervasyon_olusturma',
        'Kullanici yeni rezervasyon olusturdu.'
    );

    RETURN v_rezervasyon_id;
END;
$$;

-- 4.2 Suresi Dolan Rezervasyonlari Iptal Etme + Ceza Sistemi
-- Kural: Son 7 gun icinde 3 kez sure asimi yapan kullaniciya 24 saat ceza.
CREATE OR REPLACE FUNCTION suresi_dolan_rezervasyonlari_iptal_et()
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
    v_iptal_sayisi INT := 0;
    r RECORD;
    v_sure_asimi_sayisi INT;
BEGIN
    FOR r IN
        SELECT rezervasyon_id, kullanici_id
        FROM rezervasyonlar
        WHERE durum = 'beklemede'
          AND baslangic_zamani + INTERVAL '15 minutes' < CURRENT_TIMESTAMP
          AND rezervasyon_id NOT IN (
              SELECT rezervasyon_id
              FROM qr_kontrol_kayitlari
              WHERE durum = 'basarili'
          )
    LOOP
        UPDATE rezervasyonlar
        SET durum = 'sure_asimi'
        WHERE rezervasyon_id = r.rezervasyon_id;

        v_iptal_sayisi := v_iptal_sayisi + 1;

        -- Son 7 gun icindeki sure asimi sayisi
        SELECT COUNT(*)
        INTO v_sure_asimi_sayisi
        FROM rezervasyonlar
        WHERE kullanici_id = r.kullanici_id
          AND durum = 'sure_asimi'
          AND olusturma_tarihi >= CURRENT_TIMESTAMP - INTERVAL '7 days';

        -- 3 veya daha fazla sure asimi varsa 24 saat ceza ver
        IF v_sure_asimi_sayisi >= 3 THEN
            IF NOT EXISTS (
                SELECT 1
                FROM ceza_kayitlari
                WHERE kullanici_id = r.kullanici_id
                  AND aktif_mi = TRUE
                  AND ceza_bitis > CURRENT_TIMESTAMP
            ) THEN
                INSERT INTO ceza_kayitlari (
                    kullanici_id,
                    rezervasyon_id,
                    ceza_nedeni,
                    ceza_bitis
                )
                VALUES (
                    r.kullanici_id,
                    r.rezervasyon_id,
                    'Son 7 gun icinde 3 kez rezervasyon olusturup dogrulama yapmadigi icin 24 saat rezervasyon yasagi.',
                    CURRENT_TIMESTAMP + INTERVAL '24 hours'
                );
            END IF;
        END IF;
    END LOOP;

    INSERT INTO aktivite_loglari (
        kullanici_id,
        islem_tipi,
        aciklama
    )
    VALUES (
        NULL,
        'otomatik_rezervasyon_iptali',
        v_iptal_sayisi || ' adet rezervasyon sure asimi nedeniyle iptal edildi.'
    );

    RETURN v_iptal_sayisi;
END;
$$;

-- 4.3 QR/NFC Dogrulama
CREATE OR REPLACE FUNCTION qr_nfc_dogrulama(
    p_nfc_uid VARCHAR,
    p_qr_kod VARCHAR
)
RETURNS TEXT
LANGUAGE plpgsql
AS $$
DECLARE
    v_kullanici_id INT;
    v_masa_id INT;
    v_rezervasyon_id INT;
BEGIN
    -- NFC UID ile aktif kullaniciyi bul
    SELECT k.kullanici_id
    INTO v_kullanici_id
    FROM dijital_kimlikler dk
    JOIN kullanicilar k ON dk.kullanici_id = k.kullanici_id
    WHERE dk.nfc_uid = p_nfc_uid
      AND dk.aktif_mi = TRUE
      AND k.aktif_mi = TRUE;

    IF v_kullanici_id IS NULL THEN
        RAISE EXCEPTION 'NFC kimligi dogrulanamadi.';
    END IF;

    -- QR kod ile aktif masayi bul
    SELECT masa_id
    INTO v_masa_id
    FROM masa_qr_kodlari
    WHERE qr_kod = p_qr_kod
      AND aktif_mi = TRUE;

    IF v_masa_id IS NULL THEN
        RAISE EXCEPTION 'QR kod gecersiz veya pasif.';
    END IF;

    -- Bu kullanici ve masa icin dogrulanabilir rezervasyonu bul
    SELECT rezervasyon_id
    INTO v_rezervasyon_id
    FROM rezervasyonlar
    WHERE kullanici_id = v_kullanici_id
      AND masa_id = v_masa_id
      AND durum = 'beklemede'
      AND CURRENT_TIMESTAMP BETWEEN baslangic_zamani
                              AND baslangic_zamani + INTERVAL '15 minutes'
    ORDER BY baslangic_zamani ASC
    LIMIT 1;

    IF v_rezervasyon_id IS NULL THEN
        RAISE EXCEPTION 'Bu kullanici ve masa icin dogrulanabilir aktif rezervasyon bulunamadi.';
    END IF;

    -- QR kontrol kaydi olustur
    INSERT INTO qr_kontrol_kayitlari (
        rezervasyon_id,
        kullanici_id,
        masa_id,
        qr_kod,
        durum
    )
    VALUES (
        v_rezervasyon_id,
        v_kullanici_id,
        v_masa_id,
        p_qr_kod,
        'basarili'
    );

    -- Rezervasyonu aktif yap
    UPDATE rezervasyonlar
    SET durum = 'aktif'
    WHERE rezervasyon_id = v_rezervasyon_id;

    -- Aktivite logu
    INSERT INTO aktivite_loglari (
        kullanici_id,
        islem_tipi,
        aciklama
    )
    VALUES (
        v_kullanici_id,
        'qr_nfc_dogrulama',
        'Kullanici NFC ve QR dogrulamasi ile rezervasyonunu aktif hale getirdi.'
    );

    RETURN 'Dogrulama basarili. Rezervasyon aktif hale getirildi.';
END;
$$;

-- 4.4 Suresi Gecen Cezalari Pasif Yap
CREATE OR REPLACE FUNCTION suresi_gecen_cezalari_pasif_yap()
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
    v_sayi INT;
BEGIN
    UPDATE ceza_kayitlari
    SET aktif_mi = FALSE
    WHERE aktif_mi = TRUE
      AND ceza_bitis <= CURRENT_TIMESTAMP;

    GET DIAGNOSTICS v_sayi = ROW_COUNT;
    RETURN v_sayi;
END;
$$;

-- 4.5 Uygun Masalari Listele
CREATE OR REPLACE FUNCTION uygun_masalari_listele(
    p_baslangic_zamani TIMESTAMP,
    p_bitis_zamani TIMESTAMP
)
RETURNS TABLE (
    masa_id INT,
    masa_no VARCHAR,
    alan_adi VARCHAR,
    kat_no INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT m.masa_id, m.masa_no, a.alan_adi, a.kat_no
    FROM masalar m
    JOIN alanlar a ON m.alan_id = a.alan_id
    WHERE m.durum <> 'dolu'
      AND (
          a.yedi_yirmi_dort = TRUE
          OR (
              p_baslangic_zamani::TIME >= a.acilis_saati
              AND p_bitis_zamani::TIME <= a.kapanis_saati
          )
      )
      AND NOT EXISTS (
          SELECT 1
          FROM rezervasyonlar r
          WHERE r.masa_id = m.masa_id
            AND r.durum IN ('beklemede', 'aktif')
            AND p_baslangic_zamani < r.bitis_zamani
            AND p_bitis_zamani > r.baslangic_zamani
      );
END;
$$;

-- =========================================================
-- 5. TRIGGERLAR
-- =========================================================

-- 5.1 Masa Durumu Guncelleme Trigger Function
CREATE OR REPLACE FUNCTION masa_durum_guncelle()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF NEW.durum = 'beklemede' THEN
        UPDATE masalar
        SET durum = 'rezerve'
        WHERE masa_id = NEW.masa_id;

    ELSIF NEW.durum = 'aktif' THEN
        UPDATE masalar
        SET durum = 'dolu'
        WHERE masa_id = NEW.masa_id;

    ELSIF NEW.durum IN ('iptal', 'sure_asimi', 'tamamlandi') THEN
        UPDATE masalar
        SET durum = 'bos'
        WHERE masa_id = NEW.masa_id;
    END IF;

    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_masa_durum_guncelle
AFTER INSERT OR UPDATE OF durum
ON rezervasyonlar
FOR EACH ROW
EXECUTE FUNCTION masa_durum_guncelle();

-- 5.2 Rezervasyon Gecmisi Trigger Function
CREATE OR REPLACE FUNCTION rezervasyon_gecmisi_ekle()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF OLD.durum IS DISTINCT FROM NEW.durum THEN
        INSERT INTO rezervasyon_gecmisi (
            rezervasyon_id,
            eski_durum,
            yeni_durum,
            aciklama
        )
        VALUES (
            NEW.rezervasyon_id,
            OLD.durum,
            NEW.durum,
            'Rezervasyon durumu otomatik guncellendi.'
        );
    END IF;

    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_rezervasyon_gecmisi_ekle
AFTER UPDATE OF durum
ON rezervasyonlar
FOR EACH ROW
EXECUTE FUNCTION rezervasyon_gecmisi_ekle();

-- =========================================================
-- 6. TEST KOMUTLARI
-- =========================================================

-- Uygun masalari listeleme:
-- SELECT * FROM uygun_masalari_listele('2026-05-01 10:00:00', '2026-05-01 12:00:00');

-- Rezervasyon olusturma:
-- SELECT rezervasyon_olustur(1, 2, '2026-05-01 10:00:00', '2026-05-01 12:00:00');

-- QR/NFC dogrulama:
-- SELECT qr_nfc_dogrulama('NFC-AYSE-001', 'QR-MASA-101');

-- Timeout iptal kontrolu:
-- SELECT suresi_dolan_rezervasyonlari_iptal_et();

-- Suresi gecen cezalari pasif yapma:
-- SELECT suresi_gecen_cezalari_pasif_yap();
