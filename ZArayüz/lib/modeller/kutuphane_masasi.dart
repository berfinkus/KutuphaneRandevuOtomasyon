class KutuphaneMasasi {
  const KutuphaneMasasi(this.ad, this.alan, this.bosMu, {this.id = ''});

  final String id;
  final String ad;
  final String alan;
  final bool bosMu;

  factory KutuphaneMasasi.fromJson(Map<String, dynamic> json) {
    return KutuphaneMasasi(
      '${json['ad'] ?? json['name'] ?? json['tableName'] ?? ''}',
      '${json['alan'] ?? json['area'] ?? json['zone'] ?? ''}',
      json['bosMu'] == true ||
          json['available'] == true ||
          '${json['status']}'.toLowerCase().contains('available') ||
          '${json['status']}'.toLowerCase().contains('bos'),
      id: '${json['id'] ?? json['tableId'] ?? ''}',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'ad': ad, 'alan': alan, 'bosMu': bosMu};
  }
}
