import '../modeller/kullanici.dart';
import 'api_istemcisi.dart';

class KimlikServisi {
  KimlikServisi(this._api);

  final ApiIstemcisi _api;

  Future<GirisYaniti> girisYap({
    required String numara,
    required String sifre,
  }) async {
    final json =
        await _api.post(
              '/auth/login',
              body: {'numara': numara, 'password': sifre},
            )
            as Map<String, dynamic>;

    final yanit = GirisYaniti.fromJson(json);
    _api.tokenAyarla(yanit.token);
    return yanit;
  }

  Future<Kullanici> profilGetir() async {
    final json = await _api.get('/users/me') as Map<String, dynamic>;
    return Kullanici.fromJson(json);
  }

  Future<void> sifremiUnuttum(String eposta) async {
    await _api.post('/auth/forgot-password', body: {'email': eposta});
  }

  Future<void> sifreDogrulamaKoduOnayla({
    required String eposta,
    required String kod,
  }) async {
    await _api.post(
      '/auth/verify-reset-code',
      body: {'email': eposta, 'code': kod},
    );
  }

  Future<void> yeniSifreOlustur({
    required String eposta,
    required String kod,
    required String yeniSifre,
  }) async {
    await _api.post(
      '/auth/reset-password',
      body: {'email': eposta, 'code': kod, 'newPassword': yeniSifre},
    );
  }

  Future<void> sifreDegistir({
    required String eskiSifre,
    required String yeniSifre,
  }) async {
    await _api.patch(
      '/users/me/password',
      body: {'oldPassword': eskiSifre, 'newPassword': yeniSifre},
    );
  }

  void cikisYap() {
    _api.tokenTemizle();
  }
}

class GirisYaniti {
  const GirisYaniti({required this.token, required this.kullanici});

  final String token;
  final Kullanici kullanici;

  factory GirisYaniti.fromJson(Map<String, dynamic> json) {
    return GirisYaniti(
      token: '${json['token'] ?? json['accessToken'] ?? ''}',
      kullanici: Kullanici.fromJson(
        (json['user'] ?? json['kullanici'] ?? json) as Map<String, dynamic>,
      ),
    );
  }
}
