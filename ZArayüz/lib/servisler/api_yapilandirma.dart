class ApiYapilandirma {
  const ApiYapilandirma._();

  // Telefonla test ederken bu degeri backend IP adresiyle calistir:
  // flutter run --dart-define=API_BASE_URL=http://192.168.1.25:8080/api
  static const baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:8080/api',
  );

  static const baglantiZamanAsimi = Duration(seconds: 20);
}
