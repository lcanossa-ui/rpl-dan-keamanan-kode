import 'package:flutter_test/flutter_test.dart';
import '../lib/utils/validators.dart';

void main() {
  group('Pengujian Validators', () {
    // 1. Pengujian validasi email
    group('isValidEmail', () {
      test('Email yang benar harus valid', () {
        expect(Validators.isValidEmail('lidia@gmail.com'), isTrue);
      });

      test('Email tanpa @ harus tidak valid', () {
        expect(Validators.isValidEmail('lidiagmail.com'), isFalse);
      });

      test('Email tanpa domain harus tidak valid', () {
        expect(Validators.isValidEmail('lidia@'), isFalse);
      });
    });

    // 2. Pengujian sanitasi input
    group('sanitize', () {
      test('Karakter HTML berbahaya harus diubah', () {
        final result = Validators.sanitize('<script>alert("test")</script>');

        expect(result, '&lt;script&gt;alert(&quot;test&quot;)&lt;/script&gt;');
      });

      test('Tanda petik satu harus disanitasi', () {
        expect(Validators.sanitize("Lidia's"), 'Lidia&#39;s');
      });

      test('Teks biasa tetap sama', () {
        expect(Validators.sanitize('Halo Lidia'), 'Halo Lidia');
      });
    });

    // 3. Pengujian panjang teks
    group('validateText', () {
      test('Teks dengan panjang sesuai harus valid', () {
        expect(
          Validators.validateText(
            'Lidia',
            fieldName: 'Nama',
            minLength: 3,
            maxLength: 20,
          ),
          isNull,
        );
      });

      test('Teks terlalu pendek harus tidak valid', () {
        expect(
          Validators.validateText(
            'Li',
            fieldName: 'Nama',
            minLength: 3,
            maxLength: 20,
          ),
          isNotNull,
        );
      });

      test('Teks terlalu panjang harus tidak valid', () {
        expect(
          Validators.validateText(
            'Lidia Canossa de Jesus',
            fieldName: 'Nama',
            minLength: 3,
            maxLength: 10,
          ),
          isNotNull,
        );
      });

      test('Teks kosong harus tidak valid', () {
        expect(
          Validators.validateText(
            '',
            fieldName: 'Nama',
            minLength: 3,
            maxLength: 20,
          ),
          isNotNull,
        );
      });
    });
  });
}
