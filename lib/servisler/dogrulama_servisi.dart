import 'api_istemcisi.dart';

class DogrulamaServisi {
  DogrulamaServisi(this._api);

  final ApiIstemcisi _api;

  Future<void> qrDogrula({
    required String randevuId,
    required String qrKod,
  }) async {
    await _api.post(
      '/qr/verify',
      body: {'appointmentId': randevuId, 'qrCode': qrKod},
    );
  }

  Future<void> nfcDogrula({
    required String kullaniciId,
    required String nfcEtiketId,
  }) async {
    await _api.post(
      '/nfc/verify',
      body: {'userId': kullaniciId, 'nfcTagId': nfcEtiketId},
    );
  }
}
