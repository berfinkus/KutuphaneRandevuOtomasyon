import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

import '../bilesenler/kart_bilesenleri.dart';
import '../bilesenler/temel_bilesenler.dart';
import '../tema/uygulama_renkleri.dart';
import '../veriler/ornek_veriler.dart';

class KimlikEkrani extends StatefulWidget {
  const KimlikEkrani({super.key});

  @override
  State<KimlikEkrani> createState() => _KimlikEkraniState();
}

class _KimlikEkraniState extends State<KimlikEkrani> {
  String nfcMesaji =
      'NFC ile giris yapmak icin telefonunuzu turnikeye yaklastirin.';
  bool okunuyor = false;

  @override
  Widget build(BuildContext context) {
    return DuzSayfa(
      baslik: 'Kimlik',
      geriGoster: true,
      koyuBaslik: true,
      cocuk: Column(
        children: [
          const SizedBox(height: 12),
          const DijitalKimlikKarti(kullanici: OrnekVeriler.kullanici),
          const SizedBox(height: 28),
          InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: _nfcBaslat,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: UygulamaRenkleri.lacivert,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: UygulamaRenkleri.altin.withValues(alpha: 0.4),
                ),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: UygulamaRenkleri.altin.withValues(
                      alpha: 0.14,
                    ),
                    child: Icon(
                      okunuyor ? Icons.sync : Icons.nfc,
                      color: UygulamaRenkleri.altin,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      nfcMesaji,
                      style: const TextStyle(color: Colors.white, height: 1.35),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _nfcBaslat() async {
    final durum = await NfcManager.instance.checkAvailability();
    if (durum != NfcAvailability.enabled) {
      setState(() => nfcMesaji = 'Bu cihazda NFC kullanilamiyor veya kapali.');
      return;
    }

    setState(() {
      okunuyor = true;
      nfcMesaji = 'NFC oturumu basladi. Telefonu turnikeye yaklastirin.';
    });

    await NfcManager.instance.startSession(
      pollingOptions: {NfcPollingOption.iso14443, NfcPollingOption.iso15693},
      onDiscovered: (tag) async {
        setState(() {
          okunuyor = false;
          nfcMesaji =
              'NFC dogrulamasi alindi. Kullanici: ${OrnekVeriler.kullanici.numara}';
        });
        await NfcManager.instance.stopSession();
      },
    );
  }
}
