import 'dart:convert';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart' as encrypt;

class PublicRequestsTokenCrypt {
  static final Uint8List _ivBytes = Uint8List.fromList(utf8.encode('eticaPPlayVector').sublist(0, 16));

  final String secretKey;

  PublicRequestsTokenCrypt({required this.secretKey});

  String encryptToken(String token) {
    try {
      final key = _prepareKey(secretKey);

      final iv = encrypt.IV(_ivBytes);

      final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: 'PKCS7'));

      final encrypted = encrypter.encrypt(token, iv: iv);

      return encrypted.base64;
    } catch (e) {
      print('Erro ao criptografar token: $e');
      throw Exception('Erro ao criptografar token: $e');
    }
  }

  String? decryptToken(String encryptedToken) {
    try {
      final key = _prepareKey(secretKey);

      final iv = encrypt.IV(_ivBytes);

      final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: 'PKCS7'));

      final decrypted = encrypter.decrypt64(encryptedToken, iv: iv);

      return decrypted;
    } catch (e) {
      print('Erro ao descriptografar token: $e');
      return null;
    }
  }

  encrypt.Key _prepareKey(String key) {
    final keyBytes = utf8.encode(key);

    final Uint8List resultBytes = Uint8List(32);

    for (int i = 0; i < math.min(keyBytes.length, 32); i++) {
      resultBytes[i] = keyBytes[i];
    }

    return encrypt.Key(resultBytes);
  }

  String generateSecurityToken() {
    return encryptToken(secretKey);
  }

  bool testTokenCrypto() {
    final encrypted = encryptToken(secretKey);
    final decrypted = decryptToken(encrypted);
    return decrypted == secretKey;
  }
}
