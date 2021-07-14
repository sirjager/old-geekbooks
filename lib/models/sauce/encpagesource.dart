import 'package:geeklibrary/backend/crypt/cryptor.dart';
import 'package:geeklibrary/models/sauce/pagesource.dart';
import 'package:hive/hive.dart';

part 'encpagesource.g.dart';

@HiveType(typeId: 0)
class EncPageSource extends HiveObject {
  @HiveField(0)
  final String key;
  @HiveField(1)
  final source;
  EncPageSource({required this.key, required this.source});

  static EncPageSource buildEnc(PageSource sauce) {
    var _key = Encrypt.encryptSAL(sauce.key);
    var _sauce = Encrypt.encryptSAL(sauce.source);
    return EncPageSource(key: _key, source: _sauce);
  }

  static PageSource buildSauce(EncPageSource encsauce) {
    var _key = Encrypt.decryptSAL(encsauce.key);
    var _sauce = Encrypt.decryptSAL(encsauce.source);
    return PageSource(key: _key, source: _sauce);
  }
}
