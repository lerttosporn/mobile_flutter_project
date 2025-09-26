import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpConfig {
  static const String _baseUrl = 'https://api.example.com'; // เปลี่ยนให้ตรงกับ API ของคุณ

  /// Default headers for all requests
  static Map<String, String> get _defaultHeaders => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    // เพิ่ม 'Authorization': 'Bearer your_token' ถ้ามี token
  };

  /// GET request
  static Future<http.Response> get(String endpoint) async {
    final Uri url = Uri.parse('$_baseUrl$endpoint');

    final response = await http.get(url, headers: _defaultHeaders);
    _handleError(response);
    return response;
  }

  /// POST request
  static Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    final Uri url = Uri.parse('$_baseUrl$endpoint');

    final response = await http.post(
      url,
      headers: _defaultHeaders,
      body: jsonEncode(body),
    );
    _handleError(response);
    return response;
  }

  /// PUT request
  static Future<http.Response> put(String endpoint, Map<String, dynamic> body) async {
    final Uri url = Uri.parse('$_baseUrl$endpoint');

    final response = await http.put(
      url,
      headers: _defaultHeaders,
      body: jsonEncode(body),
    );
    _handleError(response);
    return response;
  }

  /// DELETE request
  static Future<http.Response> delete(String endpoint) async {
    final Uri url = Uri.parse('$_baseUrl$endpoint');

    final response = await http.delete(url, headers: _defaultHeaders);
    _handleError(response);
    return response;
  }

  /// Error handler similar to Dio interceptor
  static void _handleError(http.Response response) {
    if (response.statusCode >= 400) {
      switch (response.statusCode) {
        case 400:
          print('Bad Request');
          break;
        case 401:
          print('Unauthorized');
          break;
        case 403:
          print('Forbidden');
          break;
        case 404:
          print('Not Found');
          break;
