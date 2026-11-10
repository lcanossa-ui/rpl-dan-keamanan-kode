import 'package:flutter/foundation.dart';

/// Class untuk mengatur logging aplikasi.
class Logger {
  /// Menampilkan log untuk informasi debugging.
  static void debug(String message) {
    if (kDebugMode) {
      debugPrint('[DEBUG] $message');
    }
  }

  /// Menampilkan log informasi.
  static void info(String message) {
    if (kDebugMode) {
      debugPrint('[INFO] $message');
    }
  }

  /// Menampilkan log peringatan.
  static void warning(String message) {
    if (kDebugMode) {
      debugPrint('[WARNING] $message');
    }
  }

  /// Menampilkan log kesalahan.
  static void error(String message) {
    if (kDebugMode) {
      debugPrint('[ERROR] $message');
    }
  }
}
