import 'package:flutter/material.dart';

import '../bilesenler/kart_bilesenleri.dart';
import '../bilesenler/temel_bilesenler.dart';
import '../tema/uygulama_renkleri.dart';
import '../tema/uygulama_stilleri.dart';
import '../veriler/ornek_veriler.dart';
import 'giris_ekrani.dart';
import 'sifre_islemleri_ekranlari.dart';

class ProfilEkrani extends StatelessWidget {
  const ProfilEkrani({super.key});

  @override
  Widget build(BuildContext context) {
    final kullanici = OrnekVeriler.kullanici;
    return DuzSayfa(
      baslik: 'Profilim',
      geriGoster: true,
      cocuk: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: kartDekorasyonu(),
            child: Row(
              children: [
                const KullaniciAvatar(boyut: 76),
                const SizedBox(width: 18),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(kullanici.adSoyad, style: BolumStilleri.baslik),
                    const SizedBox(height: 4),
                    Text(
                      kullanici.rol,
                      style: const TextStyle(color: UygulamaRenkleri.soluk),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      kullanici.numara,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          ProfilSatiri(
            baslik: 'E-posta',
            deger: kullanici.eposta,
            ikon: Icons.mail_outline,
            onTap: () {},
          ),
          ProfilSatiri(
            baslik: 'Sifre',
            deger: '********',
            ikon: Icons.lock_outline,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SifreDegistirEkrani()),
            ),
          ),
          const Spacer(),
          CizgiliButon(
            metin: 'Cikis Yap',
            tehlike: true,
            onPressed: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const GirisEkrani()),
              (_) => false,
            ),
          ),
        ],
      ),
    );
  }
}
