import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../bilesenler/temel_bilesenler.dart';
import '../tema/uygulama_renkleri.dart';
import 'randevu_al_ekrani.dart';

class QrOkutEkrani extends StatefulWidget {
  const QrOkutEkrani({super.key});

  @override
  State<QrOkutEkrani> createState() => _QrOkutEkraniState();
}

class _QrOkutEkraniState extends State<QrOkutEkrani> {
  final MobileScannerController controller = MobileScannerController(
    formats: [BarcodeFormat.qrCode],
  );
  bool okundu = false;

  @override
  void dispose() {
    unawaited(controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UygulamaRenkleri.lacivert,
      body: Stack(
        children: [
          Positioned.fill(
            child: MobileScanner(
              controller: controller,
              fit: BoxFit.cover,
              onDetect: _qrOkundu,
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: UygulamaRenkleri.lacivert.withValues(alpha: 0.45),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(22, 12, 22, 28),
              child: Column(
                children: [
                  UstBaslik(
                    baslik: 'QR Okut',
                    geriGoster: true,
                    acikRenk: true,
                    sag: IconButton(
                      icon: const Icon(
                        Icons.flash_on_outlined,
                        color: Colors.white,
                      ),
                      onPressed: () => unawaited(controller.toggleTorch()),
                    ),
                  ),
                  const SizedBox(height: 28),
                  const Text(
                    'Lutfen randevu aldiginiz masanin QR kodunu okutun.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  const Spacer(),
                  const QrCercevesi(),
                  const Spacer(),
                  Text(
                    okundu
                        ? 'QR kod okundu, dogrulama yapiliyor.'
                        : 'Dogrulama icin QR kodu cerceve icine yerlestirin.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _qrOkundu(BarcodeCapture capture) {
    if (okundu) {
      return;
    }

    String? kod;
    for (final barcode in capture.barcodes) {
      final raw = barcode.rawValue;
      if (raw != null && raw.trim().isNotEmpty) {
        kod = raw;
        break;
      }
    }

    if (kod == null) {
      return;
    }

    setState(() => okundu = true);
    unawaited(controller.stop());
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const RandevuBasariliEkrani()),
    );
  }
}
