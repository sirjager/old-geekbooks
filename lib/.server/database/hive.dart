import 'package:geekbooks/export/export.dart';
import 'package:geekbooks/models/download/downlenk.dart';
import 'package:geekbooks/models/page/pagesource.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveSauce {
  static Future<Box<PageSource>> openBox(String box) async =>
      await Hive.openBox<PageSource>(box);
  static Future<PageSource?> getData(Box<PageSource> _box, String key) async =>
      _box.get(key);

  static Future<void> putData(Box<PageSource> _box, String key, value) async =>
      await _box.put(key, value);
  static Future<void> deleteData(Box<PageSource> _box, String key) async =>
      await _box.delete(key);
}

class HiveBooks {
  static Future<Box<Book>> openBox(String box) async => await Hive.openBox(box);
  static Future<Book?> getData(Box<Book> _box, String key) async =>
      _box.get(key);
  static Future<void> putData(Box<Book> _box, String key, value) async =>
      await _box.put(key, value);
  static Future<void> deleteData(Box<Book> _box, String key) async =>
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
