import 'api_istemcisi.dart';

class KutuphaneServisi {
  KutuphaneServisi(this._api);

  final ApiIstemcisi _api;

  Future<DolulukBilgisi> dolulukGetir() async {
    final json = await _api.get('/library/occupancy') as Map<String, dynamic>;
    return DolulukBilgisi.fromJson(json);
  }
}

class DolulukBilgisi {
  const DolulukBilgisi({
    required this.yuzde,
    required this.doluKisi,
    required this.kapasite,
    required this.bosMasa,
    this.enYogunSaat = '',
  });

  final int yuzde;
  final int doluKisi;
  final int kapasite;
  final int bosMasa;
  final String enYogunSaat;

  factory DolulukBilgisi.fromJson(Map<String, dynamic> json) {
    return DolulukBilgisi(
      yuzde: _intOku(json['yuzde'] ?? json['percentage']),
      doluKisi: _intOku(json['doluKisi'] ?? json['occupiedCount']),
      kapasite: _intOku(json['kapasite'] ?? json['capacity']),
      bosMasa: _intOku(json['bosMasa'] ?? json['availableTables']),
      enYogunSaat: '${json['enYogunSaat'] ?? json['peakHour'] ?? ''}',
    );
  }

  static int _intOku(Object? value) {
    if (value is int) {
      return value;
    }
    return int.tryParse('$value') ?? 0;
  }
}
