import 'package:flutter/material.dart';

import '../bilesenler/kart_bilesenleri.dart';
import '../bilesenler/secim_bilesenleri.dart';
import '../bilesenler/temel_bilesenler.dart';
import '../modeller/kutuphane_masasi.dart';
import '../tema/uygulama_renkleri.dart';
import '../tema/uygulama_stilleri.dart';
import '../veriler/ornek_veriler.dart';
import 'kabuk_ekrani.dart';

class RandevuAlEkrani extends StatefulWidget {
  const RandevuAlEkrani({super.key});

  @override
  State<RandevuAlEkrani> createState() => _RandevuAlEkraniState();
}

class _RandevuAlEkraniState extends State<RandevuAlEkrani> {
  String seciliKat = 'Tum Katlar';
  String seciliSaat = 'Tum Saatler';

  List<KutuphaneMasasi> get filtreliMasalar {
    return OrnekVeriler.masalar.where((masa) {
      final katUyuyor =
          seciliKat == 'Tum Katlar' || masa.ad.startsWith(seciliKat);
      return katUyuyor;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DuzSayfa(
      baslik: 'Randevu Al',
      geriGoster: true,
      cocuk: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Bos Masalar', style: BolumStilleri.baslik),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: FiltreAcilirListe(
                  deger: seciliKat,
                  secenekler: const [
                    'Tum Katlar',
                    '3. Kat',
                    '4. Kat',
                    '5. Kat',
                    '6. Kat',
                  ],
                  onChanged: (value) =>
                      setState(() => seciliKat = value ?? seciliKat),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FiltreAcilirListe(
                  deger: seciliSaat,
                  secenekler: const [
                    'Tum Saatler',
                    '08:00 - 10:00',
                    '10:00 - 14:00',
                    '14:00 - 18:00',
                  ],
                  onChanged: (value) =>
                      setState(() => seciliSaat = value ?? seciliSaat),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          if (filtreliMasalar.isEmpty)
            const BosDurum(metin: 'Secilen filtrelere uygun bos masa yok.')
          else
            ...filtreliMasalar.map(
              (masa) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: MasaSatiri(
                  masa: masa,
                  vurgulu: masa.ad == OrnekVeriler.aktifRandevu.masaAdi,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MasaSaatSecimiEkrani(masa: masa),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class MasaSaatSecimiEkrani extends StatefulWidget {
  const MasaSaatSecimiEkrani({super.key, required this.masa});

  final KutuphaneMasasi masa;

  @override
  State<MasaSaatSecimiEkrani> createState() => _MasaSaatSecimiEkraniState();
}

class _MasaSaatSecimiEkraniState extends State<MasaSaatSecimiEkrani> {
  int seciliGun = 0;
  String baslangic = '10:00';
  String bitis = '14:00';

  @override
  Widget build(BuildContext context) {
    return DuzSayfa(
      baslik: 'Masa ve Saat Secimi',
      geriGoster: true,
      cocuk: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: kartDekorasyonu(),
            child: Row(
              children: [
                const Icon(
                  Icons.table_restaurant_outlined,
                  color: UygulamaRenkleri.altin,
                  size: 42,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(widget.masa.ad, style: BolumStilleri.baslik),
                ),
                const DurumEtiketi(metin: 'Bos', renk: UygulamaRenkleri.yesil),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text('Tarih Secin', style: BolumStilleri.baslik),
          const SizedBox(height: 12),
          Row(
            children: [
              TarihSecimKutusu(
                metin: 'Bugun\n24 Mayis',
                secili: seciliGun == 0,
                onTap: () => setState(() => seciliGun = 0),
              ),
              TarihSecimKutusu(
                metin: 'Yarin\n25 Mayis',
                secili: seciliGun == 1,
                onTap: () => setState(() => seciliGun = 1),
              ),
              TarihSecimKutusu(
                metin: 'Pazartesi\n27 Mayis',
                secili: seciliGun == 2,
                onTap: () => setState(() => seciliGun = 2),
              ),
              TarihSecimKutusu(
                metin: 'Sali\n28 Mayis',
                secili: seciliGun == 3,
                onTap: () => setState(() => seciliGun = 3),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text('Saat Araligi Secin', style: BolumStilleri.baslik),
          const SizedBox(height: 12),
          SaatSecimKutusu(
            baslik: 'Baslangic Saati',
            deger: baslangic,
            onChanged: (value) =>
                setState(() => baslangic = value ?? baslangic),
          ),
          const SizedBox(height: 14),
          SaatSecimKutusu(
            baslik: 'Bitis Saati',
            deger: bitis,
            onChanged: (value) => setState(() => bitis = value ?? bitis),
          ),
          const Spacer(),
          BirincilButon(
            metin: 'Randevuyu Olustur',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const RandevuBasariliEkrani()),
            ),
          ),
        ],
      ),
    );
  }
}

class RandevuBasariliEkrani extends StatelessWidget {
  const RandevuBasariliEkrani({super.key});

  @override
  Widget build(BuildContext context) {
    UygulamaOturumu.aktifRandevuIptalEdildi.value = false;
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
                'Dogrulama Basarili!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Randevunuz aktif edildi.',
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
              const SizedBox(height: 30),
              RandevuOzetKutusu(randevu: OrnekVeriler.aktifRandevu),
              const Spacer(),
              BirincilButon(
                metin: 'Tamam',
                onPressed: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const KabukEkrani()),
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
