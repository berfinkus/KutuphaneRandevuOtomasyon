import 'package:flutter/material.dart';

import '../bilesenler/temel_bilesenler.dart';
import 'giris_ekrani.dart';

class UyeOlEkrani extends StatefulWidget {
  const UyeOlEkrani({super.key});

  @override
  State<UyeOlEkrani> createState() => _UyeOlEkraniState();
}

class _UyeOlEkraniState extends State<UyeOlEkrani> {
  final adController = TextEditingController();
  final numaraController = TextEditingController();
  final epostaController = TextEditingController();
  final sifreController = TextEditingController();

  @override
  void dispose() {
    adController.dispose();
    numaraController.dispose();
    epostaController.dispose();
    sifreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DuzSayfa(
      baslik: 'Uye Ol',
      geriGoster: true,
      cocuk: Column(
        children: [
          const SizedBox(height: 24),
          const UniversiteIsareti(boyut: 68),
          const SizedBox(height: 34),
          UygulamaMetinAlani(
            controller: adController,
            ipucu: 'Ad Soyad',
            ikon: Icons.person_outline,
          ),
          const SizedBox(height: 14),
          UygulamaMetinAlani(
            controller: numaraController,
            ipucu: 'Ogrenci / Personel No',
            ikon: Icons.badge_outlined,
          ),
          const SizedBox(height: 14),
          UygulamaMetinAlani(
            controller: epostaController,
            ipucu: 'E-posta',
            ikon: Icons.mail_outline,
          ),
          const SizedBox(height: 14),
          UygulamaMetinAlani(
            controller: sifreController,
            ipucu: 'Sifre',
            ikon: Icons.lock_outline,
            sifre: true,
          ),
          const SizedBox(height: 28),
          BirincilButon(
            metin: 'Uye Ol',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Uyelik kaydi olusturuldu. Giris yapabilirsiniz.',
                  ),
                ),
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const GirisEkrani()),
              );
            },
          ),
          const SizedBox(height: 20),
          const YaziliAyirici(metin: 'veya'),
          const SizedBox(height: 20),
          CizgiliButon(
            metin: 'Giris Yap',
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const GirisEkrani()),
            ),
          ),
        ],
      ),
    );
  }
}
