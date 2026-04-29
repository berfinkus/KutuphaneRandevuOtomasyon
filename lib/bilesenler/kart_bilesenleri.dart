import 'package:flutter/material.dart';

import '../modeller/kullanici.dart';
import '../modeller/kutuphane_masasi.dart';
import '../modeller/randevu.dart';
import '../tema/uygulama_renkleri.dart';
import '../tema/uygulama_stilleri.dart';
import 'temel_bilesenler.dart';

class AktifRandevuKarti extends StatelessWidget {
  const AktifRandevuKarti({
    super.key,
    required this.randevu,
    required this.onQr,
  });

  final Randevu randevu;
  final VoidCallback onQr;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: kartDekorasyonu(
        border: UygulamaRenkleri.altin.withValues(alpha: 0.4),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Aktif Randevum',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 8),
                Text(
                  randevu.saatAraligi,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  randevu.masaAdi,
                  style: const TextStyle(color: UygulamaRenkleri.lacivert2),
                ),
                const SizedBox(height: 10),
                const DurumEtiketi(
                  metin: 'Onaylandi',
                  renk: UygulamaRenkleri.yesil,
                ),
              ],
            ),
          ),
          QrButonu(onPressed: onQr),
        ],
      ),
    );
  }
}

class DolulukKarti extends StatelessWidget {
  const DolulukKarti({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: UygulamaRenkleri.lacivert,
        borderRadius: BorderRadius.circular(12),
        boxShadow: golge(),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 112,
            height: 112,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: 0.68,
                  strokeWidth: 12,
                  color: UygulamaRenkleri.altin,
                  backgroundColor: Colors.white12,
                  strokeCap: StrokeCap.round,
                ),
                const Text.rich(
                  TextSpan(
                    text: '%68\n',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                    ),
                    children: [
                      TextSpan(
                        text: 'Dolu',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Kutuphane Doluluk Orani',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 18),
                Icon(Icons.groups_outlined, color: Colors.white, size: 28),
                SizedBox(height: 6),
                Text(
                  '136 / 200\nKisi',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MasaSatiri extends StatelessWidget {
  const MasaSatiri({
    super.key,
    required this.masa,
    this.vurgulu = false,
    this.onTap,
  });

  final KutuphaneMasasi masa;
  final bool vurgulu;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: vurgulu
              ? UygulamaRenkleri.altin.withValues(alpha: 0.16)
              : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: vurgulu
                ? UygulamaRenkleri.altin.withValues(alpha: 0.5)
                : UygulamaRenkleri.cizgi,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                masa.ad,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
            const DurumEtiketi(metin: 'Bos', renk: UygulamaRenkleri.yesil),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right, color: UygulamaRenkleri.soluk),
          ],
        ),
      ),
    );
  }
}

class RandevuKarti extends StatelessWidget {
  const RandevuKarti({
    super.key,
    required this.randevu,
    this.iptalGoster = false,
    this.onIptal,
    this.onQr,
  });

  final Randevu randevu;
  final bool iptalGoster;
  final VoidCallback? onIptal;
  final VoidCallback? onQr;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: kartDekorasyonu(
        border: randevu.durum == RandevuDurumu.aktif
            ? UygulamaRenkleri.altin.withValues(alpha: 0.5)
            : UygulamaRenkleri.cizgi,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 58,
            child: Column(
              children: [
                Text(
                  randevu.gun,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(randevu.ay),
                Text(randevu.haftaGunu, style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
          Container(
            width: 1,
            height: 78,
            color: UygulamaRenkleri.cizgi,
            margin: const EdgeInsets.symmetric(horizontal: 12),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  randevu.saatAraligi,
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 8),
                Text(
                  randevu.masaAdi,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                DurumEtiketi(
                  metin: randevu.durumMetni,
                  renk: switch (randevu.durum) {
                    RandevuDurumu.aktif => UygulamaRenkleri.yesil,
                    RandevuDurumu.tamamlandi => UygulamaRenkleri.yesil,
                    RandevuDurumu.iptal => UygulamaRenkleri.kirmizi,
                  },
                ),
                if (iptalGoster) ...[
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 36,
                    child: OutlinedButton.icon(
                      onPressed: onIptal,
                      icon: const Icon(Icons.cancel_outlined, size: 18),
                      label: const Text('Iptal Et'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: UygulamaRenkleri.kirmizi,
                        side: const BorderSide(color: UygulamaRenkleri.kirmizi),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (randevu.durum == RandevuDurumu.aktif)
            QrButonu(onPressed: onQr ?? () {}),
        ],
      ),
    );
  }
}

class RandevuOzetKutusu extends StatelessWidget {
  const RandevuOzetKutusu({super.key, required this.randevu});

  final Randevu randevu;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            randevu.saatAraligi,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 10),
          Text(
            randevu.masaAdi,
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 4),
          Text('${randevu.gun} ${randevu.ay} ${randevu.haftaGunu}'),
          const SizedBox(height: 12),
          const DurumEtiketi(metin: 'Onaylandi', renk: UygulamaRenkleri.yesil),
        ],
      ),
    );
  }
}

class DijitalKimlikKarti extends StatelessWidget {
  const DijitalKimlikKarti({super.key, required this.kullanici});

  final Kullanici kullanici;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 330,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: golge(),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          children: [
            Container(height: 112, color: UygulamaRenkleri.altin),
            Positioned(
              top: 18,
              left: 0,
              right: 0,
              child: Column(
                children: const [
                  UniversiteIsareti(boyut: 42),
                  SizedBox(height: 4),
                  Text(
                    'INONU UNIVERSITESI',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                  Text(
                    'OGRENCI KIMLIK',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 84,
              left: -24,
              right: -24,
              child: Container(
                height: 70,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(80)),
                ),
              ),
            ),
            Positioned(
              top: 114,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  const KullaniciAvatar(boyut: 112),
                  const SizedBox(height: 14),
                  Text(
                    kullanici.adSoyad,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    kullanici.rol,
                    style: const TextStyle(color: UygulamaRenkleri.soluk),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 42, vertical: 14),
                    child: Divider(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 34),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Ogrenci No',
                              style: TextStyle(
                                color: UygulamaRenkleri.soluk,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              kullanici.numara,
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        const Text(
                          'NFC',
                          style: TextStyle(fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(width: 6),
                        const Icon(Icons.contactless_outlined),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QrButonu extends StatelessWidget {
  const QrButonu({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: UygulamaRenkleri.altin,
        side: const BorderSide(color: UygulamaRenkleri.altin),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.qr_code_scanner),
          SizedBox(height: 4),
          Text('QR Okut', style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

class ProfilSatiri extends StatelessWidget {
  const ProfilSatiri({
    super.key,
    required this.baslik,
    required this.deger,
    required this.ikon,
    required this.onTap,
  });

  final String baslik;
  final String deger;
  final IconData ikon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: kartDekorasyonu(),
      child: ListTile(
        leading: Icon(ikon, color: UygulamaRenkleri.altin),
        title: Text(baslik),
        subtitle: Text(deger),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}

class IstatistikSatiri extends StatelessWidget {
  const IstatistikSatiri({
    super.key,
    required this.ikon,
    required this.baslik,
    required this.deger,
  });

  final IconData ikon;
  final String baslik;
  final String deger;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: kartDekorasyonu(),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: UygulamaRenkleri.altin.withValues(alpha: 0.15),
            child: Icon(ikon, color: UygulamaRenkleri.altin),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              baslik,
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
          Text(deger, style: const TextStyle(fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }
}

class DuyuruSatiri extends StatelessWidget {
  const DuyuruSatiri({
    super.key,
    required this.baslik,
    required this.aciklama,
    required this.tarih,
  });

  final String baslik;
  final String aciklama;
  final String tarih;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: kartDekorasyonu(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: UygulamaRenkleri.altin.withValues(alpha: 0.15),
            child: const Icon(
              Icons.campaign_outlined,
              color: UygulamaRenkleri.altin,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  baslik,
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 6),
                Text(
                  aciklama,
                  style: const TextStyle(
                    color: UygulamaRenkleri.soluk,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  tarih,
                  style: const TextStyle(
                    color: UygulamaRenkleri.altin,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AyarSatiri extends StatelessWidget {
  const AyarSatiri({
    super.key,
    required this.ikon,
    required this.baslik,
    required this.deger,
  });

  final IconData ikon;
  final String baslik;
  final String deger;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: kartDekorasyonu(),
      child: ListTile(
        leading: Icon(ikon, color: UygulamaRenkleri.altin),
        title: Text(
          baslik,
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(deger, style: const TextStyle(color: UygulamaRenkleri.soluk)),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}
