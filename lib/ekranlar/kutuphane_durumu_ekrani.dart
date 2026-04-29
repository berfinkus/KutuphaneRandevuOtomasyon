import 'package:flutter/material.dart';

import '../bilesenler/kart_bilesenleri.dart';
import '../bilesenler/temel_bilesenler.dart';

class KutuphaneDurumuEkrani extends StatelessWidget {
  const KutuphaneDurumuEkrani({super.key});

  @override
  Widget build(BuildContext context) {
    return DuzSayfa(
      baslik: 'Kutuphane Durumu',
      geriGoster: true,
      cocuk: Column(
        children: const [
          DolulukKarti(),
          SizedBox(height: 18),
          IstatistikSatiri(
            ikon: Icons.people_outline,
            baslik: 'Toplam Kapasite',
            deger: '200 Kisi',
          ),
          IstatistikSatiri(
            ikon: Icons.event_seat_outlined,
            baslik: 'Bos Masa',
            deger: '64',
          ),
          IstatistikSatiri(
            ikon: Icons.schedule_outlined,
            baslik: 'En Yogun Saat',
            deger: '13:00 - 16:00',
          ),
        ],
      ),
    );
  }
}
