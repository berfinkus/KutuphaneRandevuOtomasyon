import 'package:flutter/material.dart';

import '../modeller/kullanici.dart';
import '../modeller/kutuphane_masasi.dart';
import '../modeller/randevu.dart';

class OrnekVeriler {
  static const kullanici = Kullanici(
    adSoyad: 'Ahmet Yilmaz',
    rol: 'Ogrenci',
    numara: '2021123456',
    eposta: 'ahmetyilmaz@ogr.inonu.edu.tr',
  );

  static const aktifRandevu = Randevu(
    gun: '24',
    ay: 'Mayis',
    haftaGunu: 'Cuma',
    saatAraligi: '10:00 - 14:00',
    masaAdi: '3. Kat - 5. Masa',
    kat: '3. Kat',
    durumMetni: 'Onaylandi',
    durum: RandevuDurumu.aktif,
  );

  static const randevular = [
    aktifRandevu,
    Randevu(
      gun: '20',
      ay: 'Mayis',
      haftaGunu: 'Pazartesi',
      saatAraligi: '14:00 - 18:00',
      masaAdi: '4. Kat - 5. Masa',
      kat: '4. Kat',
      durumMetni: 'Tamamlandi',
      durum: RandevuDurumu.tamamlandi,
    ),
    Randevu(
      gun: '18',
      ay: 'Mayis',
      haftaGunu: 'Cumartesi',
      saatAraligi: '10:00 - 12:00',
      masaAdi: '3. Kat - 12. Masa',
      kat: '3. Kat',
      durumMetni: 'Iptal Edildi',
      durum: RandevuDurumu.iptal,
    ),
  ];

  static const masalar = [
    KutuphaneMasasi('3. Kat - 5. Masa', 'Pencere Kenari', true),
    KutuphaneMasasi('3. Kat - 12. Masa', 'Grup Calisma Alani', true),
    KutuphaneMasasi('4. Kat - 2. Masa', 'Sessiz Alan', true),
    KutuphaneMasasi('4. Kat - 8. Masa', 'Pencere Kenari', true),
    KutuphaneMasasi('5. Kat - 7. Masa', 'Genel Alan', true),
    KutuphaneMasasi('5. Kat - 11. Masa', 'Sessiz Alan', true),
    KutuphaneMasasi('6. Kat - 3. Masa', 'Genel Alan', true),
  ];
}

class UygulamaOturumu {
  static final aktifRandevuIptalEdildi = ValueNotifier<bool>(false);
}
