import 'package:geekbooks/backend/crypt/encpack.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveStorage {
  static Future<EncPack?> getPack(Box<EncPack> _box, String key) async {
    return _box.get(key);
  }

  // static Future<void> savePack(
  //     Box<EncPack> _box, String key, EncPack pack) async {
  //   return await _box.put(key, pack);
  // }

  // static Future<void> deletePack(Box<EncPack> _box, String key) async {
  //   return await _box.delete(key);
  // }
}
