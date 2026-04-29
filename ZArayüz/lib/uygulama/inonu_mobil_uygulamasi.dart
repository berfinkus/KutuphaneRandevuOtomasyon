import 'package:flutter/material.dart';

import '../ekranlar/karsilama_ekrani.dart';
import '../tema/uygulama_renkleri.dart';

class InonuMobilApp extends StatelessWidget {
  const InonuMobilApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Inonu Kutuphane',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: UygulamaRenkleri.altin,
          primary: UygulamaRenkleri.altin,
          secondary: UygulamaRenkleri.lacivert,
          surface: UygulamaRenkleri.zemin,
        ),
        scaffoldBackgroundColor: UygulamaRenkleri.zemin,
        fontFamily: 'Arial',
        useMaterial3: true,
      ),
      home: const KarsilamaEkrani(),
    );
  }
}
