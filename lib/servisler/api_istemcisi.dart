import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api_yapilandirma.dart';

class ApiIstemcisi {
  ApiIstemcisi({http.Client? httpClient, String? baseUrl})
    : _httpClient = httpClient ?? http.Client(),
      _baseUrl = baseUrl ?? ApiYapilandirma.baseUrl;

  final http.Client _httpClient;
  final String _baseUrl;
  String? _token;

  void tokenAyarla(String? token) {
    _token = token;
  }

  void tokenTemizle() {
    _token = null;
  }

  Future<dynamic> get(String path) {
    return _istek('GET', path);
  }

  Future<dynamic> post(String path, {Map<String, dynamic>? body}) {
    return _istek('POST', path, body: body);
  }

  Future<dynamic> patch(String path, {Map<String, dynamic>? body}) {
    return _istek('PATCH', path, body: body);
  }

  Future<dynamic> delete(String path, {Map<String, dynamic>? body}) {
    return _istek('DELETE', path, body: body);
  }

  Future<dynamic> _istek(
    String method,
    String path, {
    Map<String, dynamic>? body,
  }) async {
    final uri = Uri.parse('$_baseUrl$path');
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      if (_token != null && _token!.isNotEmpty)
        'Authorization': 'Bearer $_token',
    };

    final encodedBody = body == null ? null : jsonEncode(body);
    late final http.Response response;

    try {
      response = await switch (method) {
        'GET' => _httpClient.get(uri, headers: headers),
        'POST' => _httpClient.post(uri, headers: headers, body: encodedBody),
        'PATCH' => _httpClient.patch(uri, headers: headers, body: encodedBody),
        'DELETE' => _httpClient.delete(
          uri,
          headers: headers,
          body: encodedBody,
        ),
        _ => throw ArgumentError('Desteklenmeyen HTTP metodu: $method'),
      }.timeout(ApiYapilandirma.baglantiZamanAsimi);
    } on TimeoutException {
      throw const ApiHatasi('Sunucu yanit vermedi. Baglantiyi kontrol edin.');
    } on http.ClientException catch (error) {
      throw ApiHatasi('Sunucuya baglanilamadi: ${error.message}');
    }

    final decoded = _jsonCoz(response.body);
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw ApiHatasi(
        _hataMesaji(decoded) ?? 'API hatasi olustu.',
        statusCode: response.statusCode,
      );
    }

    return decoded;
  }

  dynamic _jsonCoz(String body) {
    if (body.trim().isEmpty) {
      return null;
    }
    return jsonDecode(body);
  }

  String? _hataMesaji(dynamic decoded) {
    if (decoded is Map<String, dynamic>) {
      final message =
          decoded['message'] ?? decoded['error'] ?? decoded['detail'];
      if (message != null) {
        return '$message';
      }
    }
    return null;
  }

  void dispose() {
    _httpClient.close();
  }
}

class ApiHatasi implements Exception {
  const ApiHatasi(this.mesaj, {this.statusCode});

  final String mesaj;
  final int? statusCode;

  @override
  String toString() => 'ApiHatasi($statusCode): $mesaj';
}
