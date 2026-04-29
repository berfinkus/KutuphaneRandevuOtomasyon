import 'package:flutter/material.dart';

import '../bilesenler/kart_bilesenleri.dart';
import '../bilesenler/temel_bilesenler.dart';

class AyarlarEkrani extends StatelessWidget {
  const AyarlarEkrani({super.key});

  @override
  Widget build(BuildContext context) {
    return DuzSayfa(
      baslik: 'Ayarlar',
      geriGoster: true,
      cocuk: Column(
        children: const [
          AyarSatiri(
            ikon: Icons.notifications_none,
            baslik: 'Bildirimler',
            deger: 'Acik',
          ),
          AyarSatiri(
            ikon: Icons.dark_mode_outlined,
            baslik: 'Koyu Tema',
            deger: 'Sistem',
          ),
          AyarSatiri(
            ikon: Icons.language_outlined,
            baslik: 'Dil',
            deger: 'Turkce',
          ),
        ],
      ),
    );
  }
}
