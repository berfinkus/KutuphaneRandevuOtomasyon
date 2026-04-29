import 'package:flutter/material.dart';

import '../bilesenler/temel_bilesenler.dart';
import 'giris_ekrani.dart';
import 'uye_ol_ekrani.dart';

class KarsilamaEkrani extends StatelessWidget {
  const KarsilamaEkrani({super.key});

  @override
  Widget build(BuildContext context) {
    return KoyuSayfa(
      cocuk: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(26, 34, 26, 26),
          child: Column(
            children: [
              const Spacer(),
              const UniversiteIsareti(boyut: 88),
              const SizedBox(height: 20),
              const Text(
                'INONU\nUNIVERSITESI',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                  height: 0.92,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 22),
              const Text(
                'Kutuphane\nMasa Rezervasyon Sistemi',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  height: 1.25,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(flex: 2),
              BirincilButon(
                metin: 'Giris Yap',
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const GirisEkrani()),
                ),
              ),
              const SizedBox(height: 14),
              CizgiliButon(
                metin: 'Uye Ol',
                koyu: true,
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const UyeOlEkrani()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
