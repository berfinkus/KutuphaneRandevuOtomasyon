class Kullanici {
  const Kullanici({
    this.id = '',
    required this.adSoyad,
    required this.rol,
    required this.numara,
    required this.eposta,
  });

  final String id;
  final String adSoyad;
  final String rol;
  final String numara;
  final String eposta;

  factory Kullanici.fromJson(Map<String, dynamic> json) {
    return Kullanici(
      id: '${json['id'] ?? json['userId'] ?? ''}',
      adSoyad: '${json['adSoyad'] ?? json['name'] ?? json['fullName'] ?? ''}',
      rol: '${json['rol'] ?? json['role'] ?? 'Ogrenci'}',
      numara:
          '${json['numara'] ?? json['ogrenciNo'] ?? json['studentNumber'] ?? ''}',
      eposta: '${json['eposta'] ?? json['email'] ?? ''}',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'adSoyad': adSoyad,
      'rol': rol,
      'numara': numara,
      'eposta': eposta,
    };
  }
}
