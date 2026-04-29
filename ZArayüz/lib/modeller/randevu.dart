enum RandevuDurumu { aktif, tamamlandi, iptal }

class Randevu {
  const Randevu({
    this.id = '',
    required this.gun,
    required this.ay,
    required this.haftaGunu,
    required this.saatAraligi,
    required this.masaAdi,
    required this.kat,
    required this.durumMetni,
    required this.durum,
  });

  final String id;
  final String gun;
  final String ay;
  final String haftaGunu;
  final String saatAraligi;
  final String masaAdi;
  final String kat;
  final String durumMetni;
  final RandevuDurumu durum;

  factory Randevu.fromJson(Map<String, dynamic> json) {
    final durumMetni = '${json['durumMetni'] ?? json['statusText'] ?? ''}';
    return Randevu(
      id: '${json['id'] ?? json['appointmentId'] ?? ''}',
      gun: '${json['gun'] ?? json['day'] ?? ''}',
      ay: '${json['ay'] ?? json['month'] ?? ''}',
      haftaGunu: '${json['haftaGunu'] ?? json['weekday'] ?? ''}',
      saatAraligi:
          '${json['saatAraligi'] ?? json['timeRange'] ?? json['timeSlot'] ?? ''}',
      masaAdi:
          '${json['masaAdi'] ?? json['tableName'] ?? json['deskName'] ?? ''}',
      kat: '${json['kat'] ?? json['floor'] ?? ''}',
      durumMetni: durumMetni.isEmpty ? 'Onaylandi' : durumMetni,
      durum: randevuDurumuFromJson(json['durum'] ?? json['status']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'gun': gun,
      'ay': ay,
      'haftaGunu': haftaGunu,
      'saatAraligi': saatAraligi,
      'masaAdi': masaAdi,
      'kat': kat,
      'durumMetni': durumMetni,
      'durum': durum.name,
    };
  }
}

RandevuDurumu randevuDurumuFromJson(Object? value) {
  final text = '$value'.toLowerCase();
  if (text.contains('cancel') || text.contains('iptal')) {
    return RandevuDurumu.iptal;
  }
  if (text.contains('done') ||
      text.contains('complete') ||
      text.contains('tamam')) {
    return RandevuDurumu.tamamlandi;
  }
  return RandevuDurumu.aktif;
}
