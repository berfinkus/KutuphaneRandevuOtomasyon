import '../modeller/randevu.dart';
import 'api_istemcisi.dart';

class RandevuServisi {
  RandevuServisi(this._api);

  final ApiIstemcisi _api;

  Future<Randevu?> aktifRandevuGetir() async {
    final json = await _api.get('/appointments/active');
    if (json == null) {
      return null;
    }
    return Randevu.fromJson(json as Map<String, dynamic>);
  }

  Future<List<Randevu>> gecmisRandevulariGetir() async {
    final json = await _api.get('/appointments/history');
    return _listeyiRandevuyaCevir(json);
  }

  Future<List<Randevu>> tumRandevulariGetir() async {
    final json = await _api.get('/appointments');
    return _listeyiRandevuyaCevir(json);
  }

  Future<Randevu> randevuOlustur({
    required String masaId,
    required String tarih,
    required String baslangicSaati,
    required String bitisSaati,
  }) async {
    final json =
        await _api.post(
              '/appointments',
              body: {
                'tableId': masaId,
                'date': tarih,
                'startTime': baslangicSaati,
                'endTime': bitisSaati,
              },
            )
            as Map<String, dynamic>;
    return Randevu.fromJson(json);
  }

  Future<void> randevuIptalEt(String randevuId) async {
    await _api.patch('/appointments/$randevuId/cancel');
  }

  List<Randevu> _listeyiRandevuyaCevir(dynamic json) {
    final list = json is Map<String, dynamic>
        ? json['data'] ?? json['appointments']
        : json;
    return (list as List<dynamic>)
        .whereType<Map<String, dynamic>>()
        .map(Randevu.fromJson)
        .toList();
  }
}
