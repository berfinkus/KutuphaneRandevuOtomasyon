import '../modeller/kutuphane_masasi.dart';
import 'api_istemcisi.dart';

class MasaServisi {
  MasaServisi(this._api);

  final ApiIstemcisi _api;

  Future<List<KutuphaneMasasi>> bosMasalariGetir({
    String? kat,
    String? saatAraligi,
  }) async {
    final query = <String, String>{
      if (kat != null && kat != 'Tum Katlar') 'floor': kat,
      if (saatAraligi != null && saatAraligi != 'Tum Saatler')
        'timeRange': saatAraligi,
    };
    final path = _pathOlustur('/tables/available', query);
    final json = await _api.get(path);
    return _listeyiMasayaCevir(json);
  }

  Future<List<KutuphaneMasasi>> tumMasalariGetir() async {
    final json = await _api.get('/tables');
    return _listeyiMasayaCevir(json);
  }

  List<KutuphaneMasasi> _listeyiMasayaCevir(dynamic json) {
    final list = json is Map<String, dynamic>
        ? json['data'] ?? json['tables']
        : json;
    return (list as List<dynamic>)
        .whereType<Map<String, dynamic>>()
        .map(KutuphaneMasasi.fromJson)
        .toList();
  }

  String _pathOlustur(String path, Map<String, String> query) {
    if (query.isEmpty) {
      return path;
    }
    final params = Uri(queryParameters: query).query;
    return '$path?$params';
  }
}
