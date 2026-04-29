import 'package:flutter/material.dart';

import '../bilesenler/temel_bilesenler.dart';
import 'kabuk_ekrani.dart';
import 'sifre_islemleri_ekranlari.dart';
import 'uye_ol_ekrani.dart';

class GirisEkrani extends StatefulWidget {
  const GirisEkrani({super.key});

  @override
  State<GirisEkrani> createState() => _GirisEkraniState();
}

class _GirisEkraniState extends State<GirisEkrani> {
  final numaraController = TextEditingController(text: '2021123456');
  final sifreController = TextEditingController(text: '123456');

  @override
  void dispose() {
    numaraController.dispose();
    sifreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DuzSayfa(
      baslik: 'Giris Yap',
      geriGoster: true,
      cocuk: Column(
        children: [
          const SizedBox(height: 26),
          const UniversiteIsareti(boyut: 70),
          const SizedBox(height: 44),
          UygulamaMetinAlani(
            controller: numaraController,
            ipucu: 'Ogrenci / Personel No',
            ikon: Icons.person_outline,
          ),
          const SizedBox(height: 14),
          UygulamaMetinAlani(
            controller: sifreController,
            ipucu: 'Sifre',
            ikon: Icons.lock_outline,
            sifre: true,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SifremiUnuttumEkrani()),
              ),
              child: const Text('Sifreni Unuttun?'),
            ),
          ),
          const SizedBox(height: 18),
          BirincilButon(
            metin: 'Giris Yap',
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const KabukEkrani()),
            ),
          ),
          const SizedBox(height: 20),
          const YaziliAyirici(metin: 'veya'),
          const SizedBox(height: 20),
          CizgiliButon(
            metin: 'Uye Ol',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const UyeOlEkrani()),
            ),
          ),
        ],
      ),
    );
  }
}
