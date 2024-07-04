import 'package:encrypt/encrypt.dart' as enc;
import 'package:generador_formato/encrypt/constants.dart';
import 'package:generador_formato/encrypt/encryptionmodes.dart';

class EncrypterTool {
  static encryptData(String text, enc.AESMode? _aesmode) {
    final key = enc.Key.fromUtf8(EncryptionData.encryptionKey);

    final iv = enc.IV.fromUtf8(EncryptionData.encryptionIV);

    final encrypter = enc.Encrypter(enc.AES(key,
        mode: _aesmode ?? enc.AESMode.cbc,
        padding: EncryptionModes.AESPADDING));

    final encrypted = encrypter.encrypt(text, iv: iv);

    return encrypted.base64;
  }

  static decryptData(String text, enc.AESMode _aesmode) {
    final key = enc.Key.fromUtf8(EncryptionData.encryptionKey);

    final iv = enc.IV.fromUtf8(EncryptionData.encryptionIV);

    final encrypter = enc.Encrypter(enc.AES(key,
        mode: _aesmode ?? enc.AESMode.cbc,
        padding: EncryptionModes.AESPADDING));

    final decrypted = encrypter.decrypt(enc.Encrypted.fromUtf8(text), iv: iv);

    return decrypted;
  }
}
