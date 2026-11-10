import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../config/app_config.dart';
import '../models/user.dart';
import '../models/post.dart';

/// Service untuk komunikasi HTTP dengan REST API.
class ApiService {
  static final ApiService _instance = ApiService._internal();

  factory ApiService() {
    return _instance;
  }

  ApiService._internal()
    : _client = http.Client(),
      _baseUrl = AppConfig.baseUrl;

  static ApiService get instance => _instance;

  final http.Client _client;
  final String _baseUrl;

  /// Membuat header request.
  Map<String, String> _buildHeaders() {
    return {'Content-Type': 'application/json', 'X-API-Key': AppConfig.apiKey};
  }

  /// Mengambil daftar pengguna.
  Future<List<User>> getUsers() async {
    try {
      final response = await _client
          .get(Uri.parse('$_baseUrl/users'), headers: _buildHeaders())
          .timeout(Duration(seconds: AppConfig.timeoutSeconds));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        return data.map((json) => User.fromJson(json)).toList();
      } else {
        throw Exception(
          'Gagal memuat pengguna. Status: ${response.statusCode}',
        );
      }
    } on TimeoutException {
      throw Exception('Request timeout. Periksa koneksi internet.');
    } on SocketException {
      throw Exception('Tidak ada koneksi internet.');
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }

  /// Mengambil pengguna berdasarkan ID.
  Future<User> getUserById(int id) async {
    try {
      final response = await _client
          .get(Uri.parse('$_baseUrl/users/$id'), headers: _buildHeaders())
          .timeout(Duration(seconds: AppConfig.timeoutSeconds));

      if (response.statusCode == 200) {
        return User.fromJson(jsonDecode(response.body));
      } else {
        throw Exception(
          'Gagal memuat pengguna. Status: ${response.statusCode}',
        );
      }
    } on TimeoutException {
      throw Exception('Request timeout.');
    } on SocketException {
      throw Exception('Tidak ada koneksi internet.');
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }

  /// Mengambil seluruh data Post dari API.
  Future<List<Post>> getPosts() async {
    try {
      final response = await _client
          .get(Uri.parse('$_baseUrl/posts'), headers: _buildHeaders())
          .timeout(Duration(seconds: AppConfig.timeoutSeconds));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        return data.map((json) => Post.fromJson(json)).toList();
      } else {
        throw Exception('Gagal memuat Post. Status: ${response.statusCode}');
      }
    } on TimeoutException {
      throw Exception('Request timeout. Periksa koneksi internet.');
    } on SocketException {
      throw Exception('Tidak ada koneksi internet.');
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }

  /// Mengambil Post berdasarkan ID.
  Future<Post> getPostById(int id) async {
    try {
      final response = await _client
          .get(Uri.parse('$_baseUrl/posts/$id'), headers: _buildHeaders())
          .timeout(Duration(seconds: AppConfig.timeoutSeconds));

      if (response.statusCode == 200) {
        return Post.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Gagal memuat Post. Status: ${response.statusCode}');
      }
    } on TimeoutException {
      throw Exception('Request timeout.');
    } on SocketException {
      throw Exception('Tidak ada koneksi internet.');
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }

  /// Menutup HTTP client.
  void dispose() {
    _client.close();
  }
}
