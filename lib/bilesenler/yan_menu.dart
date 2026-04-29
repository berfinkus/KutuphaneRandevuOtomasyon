import 'package:flutter/material.dart';

import '../tema/uygulama_renkleri.dart';
import 'temel_bilesenler.dart';

enum MenuHedefi {
  anaSayfa,
  randevuAl,
  randevularim,
  kutuphaneDurumu,
  kimlik,
  duyurular,
  profil,
  ayarlar,
  cikis,
}

class YanMenu extends StatelessWidget {
  const YanMenu({
    super.key,
    required this.secili,
    required this.onHedefSecildi,
  });

  final MenuHedefi secili;
  final ValueChanged<MenuHedefi> onHedefSecildi;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: UygulamaRenkleri.lacivert,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 22, 22, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const UniversiteIsareti(boyut: 42),
                  const SizedBox(width: 10),
                  const Text(
                    'INONU\nUNIVERSITESI',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      height: 0.95,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              MenuSatiri(
                ikon: Icons.home_outlined,
                metin: 'Ana Sayfa',
                secili: secili == MenuHedefi.anaSayfa,
                onTap: () => onHedefSecildi(MenuHedefi.anaSayfa),
              ),
              MenuSatiri(
                ikon: Icons.event_available_outlined,
                metin: 'Randevu Al',
                secili: secili == MenuHedefi.randevuAl,
                onTap: () => onHedefSecildi(MenuHedefi.randevuAl),
              ),
              MenuSatiri(
                ikon: Icons.calendar_month_outlined,
                metin: 'Randevularim',
                secili: secili == MenuHedefi.randevularim,
                onTap: () => onHedefSecildi(MenuHedefi.randevularim),
              ),
              MenuSatiri(
                ikon: Icons.local_library_outlined,
                metin: 'Kutuphane Durumu',
                secili: secili == MenuHedefi.kutuphaneDurumu,
                onTap: () => onHedefSecildi(MenuHedefi.kutuphaneDurumu),
              ),
              MenuSatiri(
                ikon: Icons.badge_outlined,
                metin: 'Kimlik',
                secili: secili == MenuHedefi.kimlik,
                onTap: () => onHedefSecildi(MenuHedefi.kimlik),
              ),
              MenuSatiri(
                ikon: Icons.campaign_outlined,
                metin: 'Duyurular',
                secili: secili == MenuHedefi.duyurular,
                onTap: () => onHedefSecildi(MenuHedefi.duyurular),
              ),
              MenuSatiri(
                ikon: Icons.person_outline,
                metin: 'Profilim',
                secili: secili == MenuHedefi.profil,
                onTap: () => onHedefSecildi(MenuHedefi.profil),
              ),
              MenuSatiri(
                ikon: Icons.settings_outlined,
                metin: 'Ayarlar',
                secili: secili == MenuHedefi.ayarlar,
                onTap: () => onHedefSecildi(MenuHedefi.ayarlar),
              ),
              MenuSatiri(
                ikon: Icons.logout,
                metin: 'Cikis Yap',
                onTap: () => onHedefSecildi(MenuHedefi.cikis),
              ),
              const Spacer(),
              const Center(child: UniversiteIsareti(boyut: 44)),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuSatiri extends StatelessWidget {
  const MenuSatiri({
    super.key,
    required this.ikon,
    required this.metin,
    required this.onTap,
    this.secili = false,
  });

  final IconData ikon;
  final String metin;
  final VoidCallback onTap;
  final bool secili;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: ListTile(
        selected: secili,
        selectedTileColor: UygulamaRenkleri.altin,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        dense: true,
        leading: Icon(
          ikon,
          color: secili ? Colors.black : UygulamaRenkleri.altin,
        ),
        title: Text(
          metin,
          style: TextStyle(
            color: secili ? Colors.black : Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
