import 'package:geekbooks/models/book/encbook.dart';
import 'package:geekbooks/models/download/downlenk.dart';
import 'package:geekbooks/models/sauce/encpagesource.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveSauce {
  static Future<Box<EncPageSource>> openBox(String box) async =>
      await Hive.openBox<EncPageSource>(box);
  static Future<EncPageSource?> getData(
          Box<EncPageSource> _box, String key) async =>
      _box.get(key);

  static Future<void> putData(
          Box<EncPageSource> _box, String key, value) async =>
      await _box.put(key, value);
  static Future<void> deleteData(Box<EncPageSource> _box, String key) async =>
      await _box.delete(key);
}

class HiveEncBooks {
  static Future<Box<EncBook>> openBox(String box) async =>
      await Hive.openBox(box);
  static Future<EncBook?> getData(Box<EncBook> _box, String key) async =>
      _box.get(key);
  static Future<void> putData(Box<EncBook> _box, String key, value) async =>
      await _box.put(key, value);
  static Future<void> deleteData(Box<EncBook> _box, String key) async =>
      await _box.delete(key);
}

class HiveDownlenks {
  static Future<Box<DownLenks>> openBox(String box) async =>
      await Hive.openBox(box);
  static Future<DownLenks?> getData(Box<DownLenks> _box, String key) async =>
      _box.get(key);
  static Future<void> putData(Box<DownLenks> _box, String key, value) async =>
      await _box.put(key, value);
  static Future<void> deleteData(Box<DownLenks> _box, String key) async =>
      await _box.delete(key);
}
