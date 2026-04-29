import 'package:flutter/material.dart';

import 'uygulama_renkleri.dart';

class BolumStilleri {
  static const baslik = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w900,
    color: UygulamaRenkleri.lacivert,
  );
}

BoxDecoration kartDekorasyonu({Color border = UygulamaRenkleri.cizgi}) {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    border: Border.all(color: border),
    boxShadow: golge(),
  );
}

List<BoxShadow> golge() {
  return [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.06),
      blurRadius: 16,
      offset: const Offset(0, 8),
    ),
  ];
}
