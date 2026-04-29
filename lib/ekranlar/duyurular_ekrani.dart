import 'package:flutter/material.dart';

import '../bilesenler/kart_bilesenleri.dart';
import '../bilesenler/temel_bilesenler.dart';

class DuyurularEkrani extends StatelessWidget {
  const DuyurularEkrani({super.key});

  @override
  Widget build(BuildContext context) {
    return DuzSayfa(
      baslik: 'Duyurular',
      geriGoster: true,
      cocuk: Column(
        children: const [
          DuyuruSatiri(
            baslik: 'Final haftasi rezervasyon duyurusu',
            aciklama:
                'Final haftasi boyunca masa rezervasyonlari 4 saatlik araliklarla yapilacaktir.',
            tarih: '24 Mayis',
          ),
          DuyuruSatiri(
            baslik: 'Kutuphane gece calisma saatleri',
            aciklama:
                'Merkez kutuphane sinav haftasinda 08:00 - 23:00 arasi hizmet verecektir.',
            tarih: '22 Mayis',
          ),
        ],
      ),
    );
  }
}
