import 'package:flutter/material.dart';

import '../tema/uygulama_renkleri.dart';

class IkiliSecim extends StatelessWidget {
  const IkiliSecim({
    super.key,
    required this.sol,
    required this.sag,
    required this.solSecili,
    required this.onChanged,
  });

  final String sol;
  final String sag;
  final bool solSecili;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: UygulamaRenkleri.cizgi),
      ),
      child: Row(
        children: [
          Expanded(
            child: SecimParcasi(
              metin: sol,
              secili: solSecili,
              onTap: () => onChanged(true),
            ),
          ),
          Expanded(
            child: SecimParcasi(
              metin: sag,
              secili: !solSecili,
              onTap: () => onChanged(false),
            ),
          ),
        ],
      ),
    );
  }
}

class SecimParcasi extends StatelessWidget {
  const SecimParcasi({
    super.key,
    required this.metin,
    required this.secili,
    required this.onTap,
  });

  final String metin;
  final bool secili;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: secili ? UygulamaRenkleri.altin : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          metin,
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: secili ? Colors.black : UygulamaRenkleri.soluk,
          ),
        ),
      ),
    );
  }
}

class FiltreAcilirListe extends StatelessWidget {
  const FiltreAcilirListe({
    super.key,
    required this.deger,
    required this.secenekler,
    required this.onChanged,
  });

  final String deger;
  final List<String> secenekler;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: deger,
      isExpanded: true,
      icon: const Icon(Icons.keyboard_arrow_down, size: 18),
      items: secenekler
          .map(
            (item) => DropdownMenuItem<String>(
              value: item,
              child: Text(item, overflow: TextOverflow.ellipsis),
            ),
          )
          .toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
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
      style: const TextStyle(
        color: UygulamaRenkleri.lacivert,
        fontWeight: FontWeight.w700,
        fontSize: 13,
      ),
    );
  }
}

class SaatSecimKutusu extends StatelessWidget {
  const SaatSecimKutusu({
    super.key,
    required this.baslik,
    required this.deger,
    required this.onChanged,
  });

  final String baslik;
  final String deger;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          baslik,
          style: const TextStyle(
            color: UygulamaRenkleri.soluk,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          initialValue: deger,
          items: const ['08:00', '10:00', '12:00', '14:00', '16:00', '18:00']
              .map((item) => DropdownMenuItem(value: item, child: Text(item)))
              .toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: UygulamaRenkleri.cizgi),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: UygulamaRenkleri.cizgi),
            ),
          ),
        ),
      ],
    );
  }
}

class TarihSecimKutusu extends StatelessWidget {
  const TarihSecimKutusu({
    super.key,
    required this.metin,
    required this.secili,
    required this.onTap,
  });

  final String metin;
  final bool secili;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 8),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 60,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: secili ? UygulamaRenkleri.altin : Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: secili ? UygulamaRenkleri.altin : UygulamaRenkleri.cizgi,
              ),
            ),
            child: Text(
              metin,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: secili ? Colors.black : UygulamaRenkleri.lacivert,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
