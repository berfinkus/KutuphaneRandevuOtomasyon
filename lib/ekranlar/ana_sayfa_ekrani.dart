import 'package:flutter/material.dart';

import '../bilesenler/kart_bilesenleri.dart';
import '../bilesenler/temel_bilesenler.dart';
import '../bilesenler/yan_menu.dart';
import '../tema/uygulama_stilleri.dart';
import '../veriler/ornek_veriler.dart';
import 'ayarlar_ekrani.dart';
import 'duyurular_ekrani.dart';
import 'giris_ekrani.dart';
import 'kimlik_ekrani.dart';
import 'kutuphane_durumu_ekrani.dart';
import 'profil_ekrani.dart';
import 'qr_okut_ekrani.dart';
import 'randevu_al_ekrani.dart';
import 'randevularim_ekrani.dart';

class AnaSayfaEkrani extends StatelessWidget {
  const AnaSayfaEkrani({super.key});

  @override
  Widget build(BuildContext context) {
    return DuzSayfa(
      baslik: 'Ana Sayfa',
      yanMenu: YanMenu(
        secili: MenuHedefi.anaSayfa,
        onHedefSecildi: (hedef) => _menuyeGit(context, hedef),
      ),
      solBuilder: (context) => Builder(
        builder: (innerContext) => IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => Scaffold.maybeOf(innerContext)?.openDrawer(),
        ),
      ),
      sag: IconButton(
        icon: const Icon(Icons.notifications_none),
        onPressed: () {},
      ),
      cocuk: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ValueListenableBuilder<bool>(
            valueListenable: UygulamaOturumu.aktifRandevuIptalEdildi,
            builder: (context, iptal, _) {
              if (iptal) {
                return const BosDurum(metin: 'Aktif randevunuz bulunmuyor.');
              }

              return AktifRandevuKarti(
                randevu: OrnekVeriler.aktifRandevu,
                onQr: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const QrOkutEkrani()),
                ),
              );
            },
          ),
          const SizedBox(height: 14),
          const DolulukKarti(),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Bos Masalar', style: BolumStilleri.baslik),
              const Spacer(),
              TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RandevuAlEkrani()),
                ),
                child: const Text('Tumu'),
              ),
            ],
          ),
          const SizedBox(height: 4),
          ...OrnekVeriler.masalar.take(5).map((masa) => MasaSatiri(masa: masa)),
          const Spacer(),
          BirincilButon(
            metin: 'Randevu Al',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const RandevuAlEkrani()),
            ),
          ),
        ],
      ),
    );
  }

  void _menuyeGit(BuildContext context, MenuHedefi hedef) {
    Navigator.pop(context);
    if (hedef == MenuHedefi.anaSayfa) {
      return;
    }

    if (hedef == MenuHedefi.cikis) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const GirisEkrani()),
        (_) => false,
      );
      return;
    }

    final ekran = switch (hedef) {
      MenuHedefi.randevuAl => const RandevuAlEkrani(),
      MenuHedefi.randevularim => const RandevularimEkrani(),
      MenuHedefi.kutuphaneDurumu => const KutuphaneDurumuEkrani(),
      MenuHedefi.kimlik => const KimlikEkrani(),
      MenuHedefi.duyurular => const DuyurularEkrani(),
      MenuHedefi.profil => const ProfilEkrani(),
      MenuHedefi.ayarlar => const AyarlarEkrani(),
      MenuHedefi.anaSayfa || MenuHedefi.cikis => const AnaSayfaEkrani(),
    };

    Navigator.push(context, MaterialPageRoute(builder: (_) => ekran));
  }
}
