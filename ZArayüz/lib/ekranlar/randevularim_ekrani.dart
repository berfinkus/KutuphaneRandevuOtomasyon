import 'package:flutter/material.dart';

import '../bilesenler/kart_bilesenleri.dart';
import '../bilesenler/secim_bilesenleri.dart';
import '../bilesenler/temel_bilesenler.dart';
import '../modeller/randevu.dart';
import '../tema/uygulama_renkleri.dart';
import '../tema/uygulama_stilleri.dart';
import '../veriler/ornek_veriler.dart';
import 'qr_okut_ekrani.dart';

class RandevularimEkrani extends StatefulWidget {
  const RandevularimEkrani({super.key});

  @override
  State<RandevularimEkrani> createState() => _RandevularimEkraniState();
}

class _RandevularimEkraniState extends State<RandevularimEkrani> {
  bool guncel = true;

  @override
  Widget build(BuildContext context) {
    final gorunen = guncel
        ? OrnekVeriler.randevular
              .where((item) => item.durum == RandevuDurumu.aktif)
              .toList()
        : OrnekVeriler.randevular
              .where((item) => item.durum != RandevuDurumu.aktif)
              .toList();

    return DuzSayfa(
      baslik: 'Randevularim',
      geriGoster: true,
      cocuk: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IkiliSecim(
            sol: 'Guncel',
            sag: 'Gecmis',
            solSecili: guncel,
            onChanged: (value) => setState(() => guncel = value),
          ),
          const SizedBox(height: 20),
          Text(
            guncel ? 'Aktif Randevum' : 'Gecmis Randevularim',
            style: BolumStilleri.baslik,
          ),
          const SizedBox(height: 12),
          ValueListenableBuilder<bool>(
            valueListenable: UygulamaOturumu.aktifRandevuIptalEdildi,
            builder: (context, iptal, _) {
              if (guncel && iptal) {
                return const BosDurum(metin: 'Aktif randevunuz bulunmuyor.');
              }

              return Column(
                children: gorunen
                    .map(
                      (randevu) => Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: RandevuKarti(
                          randevu: randevu,
                          iptalGoster:
                              guncel && randevu.durum == RandevuDurumu.aktif,
                          onIptal: () => _iptalOnayi(context),
                          onQr: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const QrOkutEkrani(),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _iptalOnayi(BuildContext context) async {
    final sonuc = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Randevu iptal edilsin mi?'),
        content: const Text(
          'Aktif randevunuz iptal edilirse masa tekrar bos olarak listelenir.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Vazgec'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: UygulamaRenkleri.kirmizi,
            ),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Iptal Et'),
          ),
        ],
      ),
    );

    if (sonuc == true) {
      UygulamaOturumu.aktifRandevuIptalEdildi.value = true;
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Randevu iptal edildi.')));
      }
    }
  }
}
