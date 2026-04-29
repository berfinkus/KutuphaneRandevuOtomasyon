import 'package:flutter/material.dart';

import '../bilesenler/temel_bilesenler.dart';
import '../veriler/ornek_veriler.dart';
import 'giris_ekrani.dart';

class SifreDegistirEkrani extends StatelessWidget {
  const SifreDegistirEkrani({super.key});

  @override
  Widget build(BuildContext context) {
    return DuzSayfa(
      baslik: 'Sifre Degistir',
      geriGoster: true,
      cocuk: Column(
        children: [
          const SizedBox(height: 28),
          const UygulamaMetinAlani(
            ipucu: 'Eski Sifre',
            ikon: Icons.lock_outline,
            sifre: true,
          ),
          const SizedBox(height: 14),
          const UygulamaMetinAlani(
            ipucu: 'Yeni Sifre',
            ikon: Icons.lock_outline,
            sifre: true,
          ),
          const SizedBox(height: 14),
          const UygulamaMetinAlani(
            ipucu: 'Yeni Sifre (Tekrar)',
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
              child: const Text('Sifremi Unuttum?'),
            ),
          ),
          const Spacer(),
          BirincilButon(
            metin: 'Kaydet',
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const SifreGuncellendiEkrani()),
            ),
          ),
        ],
      ),
    );
  }
}

class SifremiUnuttumEkrani extends StatelessWidget {
  const SifremiUnuttumEkrani({super.key});

  @override
  Widget build(BuildContext context) {
    return DuzSayfa(
      baslik: 'Sifremi Unuttum',
      geriGoster: true,
      cocuk: Column(
        children: [
          const SizedBox(height: 78),
          const Text(
            'Kayitli e-posta adresinize sifre sifirlama maili gonderilecektir.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, height: 1.4),
          ),
          const SizedBox(height: 34),
          UygulamaMetinAlani(
            ipucu: OrnekVeriler.kullanici.eposta,
            ikon: Icons.mail_outline,
          ),
          const SizedBox(height: 22),
          BirincilButon(
            metin: 'Mail Gonder',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const EpostaDogrulamaEkrani()),
            ),
          ),
        ],
      ),
    );
  }
}

class EpostaDogrulamaEkrani extends StatelessWidget {
  const EpostaDogrulamaEkrani({super.key});

  @override
  Widget build(BuildContext context) {
    return DuzSayfa(
      baslik: 'E-posta Dogrulama',
      geriGoster: true,
      cocuk: Column(
        children: [
          const SizedBox(height: 72),
          const Text(
            'E-postaniza gonderilen 6 haneli kodu giriniz.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 28),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              6,
              (index) => KodKutusu(numara: '${index + 1}'),
            ),
          ),
          const SizedBox(height: 18),
          const Text.rich(
            TextSpan(
              text: 'Kodu alamadiniz mi? ',
              children: [
                TextSpan(
                  text: 'Tekrar Gonder',
                  style: TextStyle(color: Color(0xFFF5A400)),
                ),
                TextSpan(text: ' (00:45)'),
              ],
            ),
          ),
          const Spacer(),
          BirincilButon(
            metin: 'Tamam',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const YeniSifreOlusturEkrani()),
            ),
          ),
        ],
      ),
    );
  }
}

class YeniSifreOlusturEkrani extends StatelessWidget {
  const YeniSifreOlusturEkrani({super.key});

  @override
  Widget build(BuildContext context) {
    return DuzSayfa(
      baslik: 'Yeni Sifre Olustur',
      geriGoster: true,
      cocuk: Column(
        children: [
          const SizedBox(height: 36),
          const UygulamaMetinAlani(
            ipucu: 'Yeni Sifre',
            ikon: Icons.lock_outline,
            sifre: true,
          ),
          const SizedBox(height: 14),
          const UygulamaMetinAlani(
            ipucu: 'Yeni Sifre (Tekrar)',
            ikon: Icons.lock_outline,
            sifre: true,
          ),
          const Spacer(),
          BirincilButon(
            metin: 'Kaydet',
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const SifreGuncellendiEkrani()),
            ),
          ),
        ],
      ),
    );
  }
}

class SifreGuncellendiEkrani extends StatelessWidget {
  const SifreGuncellendiEkrani({super.key});

  @override
  Widget build(BuildContext context) {
    return KoyuSayfa(
      cocuk: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            children: [
              const Spacer(),
              const Icon(
                Icons.check_circle_outline,
                color: Color(0xFF30C95A),
                size: 92,
              ),
              const SizedBox(height: 24),
              const Text(
                'Sifreniz Basariyla\nGuncellendi!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Spacer(),
              BirincilButon(
                metin: 'Giris Sayfasina Don',
                onPressed: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const GirisEkrani()),
                  (_) => false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
