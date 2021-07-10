import 'package:encrypt/encrypt.dart';

class Encrypt {
  //
  //!TODO********************************* < AES ALGORITHM > *********************************
  //
  static final _aesIV = IV.fromLength(16);

  //!==========< AES ENCRYPT METHOD >==========!//
  static encryptAES(data, String _key) {
    final _aesKEY = Key.fromUtf8(_key);
    final encrypterAES = Encrypter(AES(_aesKEY, mode: AESMode.cbc));
    return encrypterAES.encrypt(data, iv: _aesIV);
  }

  //!==========< DECRYPT METHOD >==========!//
  static decryptAES(data, String _key) {
    final _aesKEY = Key.fromUtf8(_key);
    final decryptor = Encrypter(AES(_aesKEY, mode: AESMode.cbc));
    return decryptor.decrypt(Encrypted.fromBase64(data), iv: _aesIV);
  }
  //
  //!TODO=============================== <  FERNET ALGORITHM > ===============================
  //

  static final _ferKEY = Key.fromUtf8("asdasdasdasdasd");
  static final _fer = Fernet(_ferKEY);
  static final encrypterFER = Encrypter(_fer);

  //!==========< FER ENCRYPT METHOD >==========!//
  static encryptFER(data) {
    return encrypterFER.encrypt(data);
  }

  //!==========< DECRYPT METHOD >==========!//
  static decryptFER(data) {
    return encrypterFER.decrypt(data);
  }

  //
  //?xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx < SALSA20 ALGORITHM > xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
  //

  static final _salKEY = Key.fromLength(32);
  static final _salIV = IV.fromLength(8);
  static final encrypterSAL = Encrypter(Salsa20(_salKEY));

  //!==========< SAL ENCRYPT METHOD >==========!//
  static encryptSAL(data) {
    return encrypterSAL.encrypt(data, iv: _salIV);
  }

  //!==========< DECRYPT METHOD >==========!//
  static decryptSAL(data) {
    return encrypterSAL.decrypt(data, iv: _salIV);
  }

  //
  //
  //

}
