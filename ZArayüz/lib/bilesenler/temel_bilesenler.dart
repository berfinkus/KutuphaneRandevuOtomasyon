import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../tema/uygulama_renkleri.dart';

class DuzSayfa extends StatelessWidget {
  const DuzSayfa({
    super.key,
    required this.baslik,
    required this.cocuk,
    this.geriGoster = false,
    this.solBuilder,
    this.sag,
    this.koyuBaslik = false,
    this.yanMenu,
  });

  final String baslik;
  final Widget cocuk;
  final bool geriGoster;
  final WidgetBuilder? solBuilder;
  final Widget? sag;
  final bool koyuBaslik;
  final Widget? yanMenu;

  @override
  Widget build(BuildContext context) {
    final icerik = SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(22, 10, 22, 22),
        child: Column(
          children: [
            UstBaslik(
              baslik: baslik,
              geriGoster: geriGoster,
              solBuilder: solBuilder,
              sag: sag,
              acikRenk: koyuBaslik,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(child: cocuk),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );

    if (koyuBaslik) {
      return KoyuSayfa(cocuk: icerik);
    }

    return Scaffold(drawer: yanMenu, body: icerik);
  }
}

class UstBaslik extends StatelessWidget {
  const UstBaslik({
    super.key,
    required this.baslik,
    this.geriGoster = false,
    this.solBuilder,
    this.sag,
    this.acikRenk = false,
  });

  final String baslik;
  final bool geriGoster;
  final WidgetBuilder? solBuilder;
  final Widget? sag;
  final bool acikRenk;

  @override
  Widget build(BuildContext context) {
    final renk = acikRenk ? Colors.white : UygulamaRenkleri.lacivert;
    return SizedBox(
      height: 44,
      child: Row(
        children: [
          SizedBox(
            width: 44,
            child: solBuilder != null
                ? solBuilder!(context)
                : geriGoster
                ? IconButton(
                    icon: Icon(Icons.arrow_back, color: renk),
                    onPressed: () => Navigator.pop(context),
                  )
                : const SizedBox(),
          ),
          Expanded(
            child: Text(
              baslik,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: renk,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          SizedBox(width: 44, child: sag ?? const SizedBox()),
        ],
      ),
    );
  }
}

class KoyuSayfa extends StatelessWidget {
  const KoyuSayfa({super.key, required this.cocuk});

  final Widget cocuk;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UygulamaRenkleri.lacivert,
      body: Stack(
        children: [
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF041721),
                    Color(0xFF0B2A36),
                    Color(0xFF051821),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: -80,
            top: 120,
            child: Icon(
              Icons.blur_on,
              color: UygulamaRenkleri.altin.withValues(alpha: 0.08),
              size: 220,
            ),
          ),
          Positioned(
            left: -60,
            bottom: 120,
            child: Icon(
              Icons.waves,
              color: UygulamaRenkleri.altin.withValues(alpha: 0.16),
              size: 260,
            ),
          ),
          cocuk,
        ],
      ),
    );
  }
}

class UniversiteIsareti extends StatelessWidget {
  const UniversiteIsareti({super.key, this.boyut = 64});

  final double boyut;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: boyut,
      height: boyut,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: UygulamaRenkleri.altin, width: 3),
      ),
      child: Icon(
        Icons.groups_rounded,
        size: boyut * 0.54,
        color: UygulamaRenkleri.altin,
      ),
    );
  }
}

class BirincilButon extends StatelessWidget {
  const BirincilButon({
    super.key,
    required this.metin,
    required this.onPressed,
  });

  final String metin;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: UygulamaRenkleri.altin,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
        ),
        onPressed: onPressed,
        child: Text(metin),
      ),
    );
  }
}

class CizgiliButon extends StatelessWidget {
  const CizgiliButon({
    super.key,
    required this.metin,
    required this.onPressed,
    this.koyu = false,
    this.tehlike = false,
  });

  final String metin;
  final VoidCallback onPressed;
  final bool koyu;
  final bool tehlike;

  @override
  Widget build(BuildContext context) {
    final renk = tehlike ? UygulamaRenkleri.kirmizi : UygulamaRenkleri.altin;
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: koyu ? Colors.white : renk,
          side: BorderSide(color: renk),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
        ),
        onPressed: onPressed,
        child: Text(metin),
      ),
    );
  }
}

class UygulamaMetinAlani extends StatefulWidget {
  const UygulamaMetinAlani({
    super.key,
    required this.ipucu,
    required this.ikon,
    this.controller,
    this.sifre = false,
  });

  final String ipucu;
  final IconData ikon;
  final TextEditingController? controller;
  final bool sifre;

  @override
  State<UygulamaMetinAlani> createState() => _UygulamaMetinAlaniState();
}

class _UygulamaMetinAlaniState extends State<UygulamaMetinAlani> {
  late bool gizli = widget.sifre;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: gizli,
      decoration: InputDecoration(
        hintText: widget.ipucu,
        prefixIcon: Icon(widget.ikon),
        suffixIcon: widget.sifre
            ? IconButton(
                icon: Icon(
                  gizli
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
                onPressed: () => setState(() => gizli = !gizli),
              )
            : null,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: UygulamaRenkleri.cizgi),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: UygulamaRenkleri.cizgi),
        ),
      ),
    );
  }
}

class YaziliAyirici extends StatelessWidget {
  const YaziliAyirici({super.key, required this.metin});

  final String metin;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            metin,
            style: const TextStyle(color: UygulamaRenkleri.soluk),
          ),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }
}

class KullaniciAvatar extends StatelessWidget {
  const KullaniciAvatar({super.key, this.boyut = 56});

  final double boyut;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: boyut,
      height: boyut,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFE7EAED),
      ),
      child: Icon(
        Icons.person,
        size: boyut * 0.64,
        color: UygulamaRenkleri.lacivert,
      ),
    );
  }
}

class DurumEtiketi extends StatelessWidget {
  const DurumEtiketi({super.key, required this.metin, required this.renk});

  final String metin;
  final Color renk;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      decoration: BoxDecoration(
        color: renk.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        metin,
        style: TextStyle(
          color: renk,
          fontWeight: FontWeight.w900,
          fontSize: 12,
        ),
      ),
    );
  }
}

class BosDurum extends StatelessWidget {
  const BosDurum({super.key, required this.metin});

  final String metin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: UygulamaRenkleri.cizgi),
      ),
      child: Text(
        metin,
        textAlign: TextAlign.center,
        style: const TextStyle(color: UygulamaRenkleri.soluk),
      ),
    );
  }
}

class KodKutusu extends StatelessWidget {
  const KodKutusu({super.key, required this.numara});

  final String numara;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 46,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: UygulamaRenkleri.cizgi),
      ),
      child: Text(numara, style: const TextStyle(fontWeight: FontWeight.w900)),
    );
  }
}

class QrCercevesi extends StatelessWidget {
  const QrCercevesi({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 230,
      height: 230,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 156,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.qr_code_2,
              color: Colors.white.withValues(alpha: 0.35),
              size: 96,
            ),
          ),
          Container(height: 2, color: UygulamaRenkleri.kirmizi),
          const Positioned(left: 0, top: 0, child: CerceveKosesi()),
          const Positioned(
            right: 0,
            top: 0,
            child: RotatedBox(quarterTurns: 1, child: CerceveKosesi()),
          ),
          const Positioned(
            right: 0,
            bottom: 0,
            child: RotatedBox(quarterTurns: 2, child: CerceveKosesi()),
          ),
          const Positioned(
            left: 0,
            bottom: 0,
            child: RotatedBox(quarterTurns: 3, child: CerceveKosesi()),
          ),
        ],
      ),
    );
  }
}

class CerceveKosesi extends StatelessWidget {
  const CerceveKosesi({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 54,
      height: 54,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          border: Border(
            left: BorderSide(color: UygulamaRenkleri.altin, width: 4),
            top: BorderSide(color: UygulamaRenkleri.altin, width: 4),
          ),
        ),
      ),
    );
  }
}

double uygunMetinBoyutu(String text, double maxWidth, double baseSize) {
  if (text.isEmpty) {
    return baseSize;
  }
  final approxWidth = text.length * baseSize * 0.55;
  if (approxWidth <= maxWidth) {
    return baseSize;
  }
  return math.max(11, baseSize * maxWidth / approxWidth);
}
