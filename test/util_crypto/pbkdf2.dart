import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/util_crypto/pbkdf2.dart';
import 'package:polkadot_dart/util_crypto/util_crypto.dart';
import 'package:polkadot_dart/utils/utils.dart';

void main() {
  pbkdf2Test();
}

void pbkdf2Test() {
  group('pbkdf2Encode', () {
    final knownSalt = Uint8List.fromList([
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      10,
      11,
      12,
      13,
      14,
      15,
      16,
      17,
      18,
      19,
      20,
      21,
      22,
      23,
      24,
      25,
      26,
      27,
      28,
      29,
      30,
      31,
      32
    ]);
    final testPassword = 'test password';
    test('has equivalent Wasm & JS results', () async {
      final salt = randomAsU8a();

      expect(
          u8aEq((await pbkdf2Encode(testPassword, salt, 2048)).password,
              (await pbkdf2Encode(testPassword, salt, 2048)).password),
          true);
    });

    test("creates known iterations ", () async {
      expect(u8aToHex((await pbkdf2Encode(testPassword, knownSalt, 2048)).password),
          '0x600ba9ad65e4294d112e028fdad5dd8fce0a6a6e6b89fb36ed006785ccc3b3aec46831b3105c24237293e6cfa1a0ef6717c113f87ff9237a3f73d210adfa6634');
    });
  });
}
