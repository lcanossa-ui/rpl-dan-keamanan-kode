/// Kumpulan fungsi validasi dan sanitasi input.
class Validators {
  /// Memvalidasi format email.
  static bool isValidEmail(String email) {
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    return regex.hasMatch(email.trim());
  }

  /// Memeriksa apakah input tidak kosong.
  static bool isNotEmpty(String? value) {
    return value != null && value.trim().isNotEmpty;
  }

  /// Memeriksa panjang teks.
  static bool hasValidLength(String value, {int min = 1, int max = 100}) {
    final length = value.trim().length;
    return length >= min && length <= max;
  }

  /// Membersihkan karakter khusus pada input.
  static String sanitize(String input) {
    return input
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&#39;')
        .trim();
  }

  /// Memvalidasi input teks.
  static String? validateText(
    String? value, {
    String fieldName = 'Field',
    int minLength = 1,
    int maxLength = 100,
  }) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName tidak boleh kosong';
    }

    if (!hasValidLength(value, min: minLength, max: maxLength)) {
      return '$fieldName harus antara $minLength-$maxLength karakter';
    }

    return null;
  }

  /// Memvalidasi email.
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email tidak boleh kosong';
    }

    if (!isValidEmail(value.trim())) {
      return 'Format email tidak valid';
    }

    return null;
  }

  /// Memvalidasi nomor telepon.
  /// Hanya angka dengan panjang 10 sampai 13 digit.
  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Nomor telepon tidak boleh kosong';
    }

    final phone = value.trim();

    final regex = RegExp(r'^[0-9]{10,13}$');

    if (!regex.hasMatch(phone)) {
      return 'Nomor telepon harus 10-13 digit angka';
    }

    return null;
  }

  /// Memvalidasi URL.
  /// URL harus dimulai dengan http:// atau https://.
  static String? validateUrl(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'URL tidak boleh kosong';
    }

    final url = value.trim();

    final regex = RegExp(r'^https?://.+', caseSensitive: false);

    if (!regex.hasMatch(url)) {
      return 'URL harus diawali http:// atau https://';
    }

    return null;
  }

  /// Memvalidasi password.
  /// Minimal 8 karakter, huruf kapital, angka, dan simbol.
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password tidak boleh kosong';
    }

    if (value.length < 8) {
      return 'Password minimal 8 karakter';
    }

    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password harus memiliki huruf kapital';
    }

    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password harus memiliki angka';
    }

    if (!RegExp(r'[^a-zA-Z0-9]').hasMatch(value)) {
      return 'Password harus memiliki simbol';
    }

    return null;
  }
}
