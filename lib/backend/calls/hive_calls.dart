import 'package:geeklibrary/backend/database/hive.dart';
import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/models/book/encbook.dart';
import 'package:geeklibrary/models/sauce/encpagesource.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveCalls {
  static Future<EncPageSource?> getHiveSauce(
          Box<EncPageSource> _box, String key) async =>
      await HiveSauce.getData(_box, key);

  static Future<List<EncBook>> getHiveBooks(
      Box<EncBook> _box, List<String> idAsList) async {
    List<EncBook> _encBooksFromHive = [];
    for (String id in idAsList) {
      EncBook? _encBook = await HiveEncBooks.getData(_box, id);
      if (_encBook != null) {
        _encBooksFromHive.add(_encBook);
      }
    }
    return _encBooksFromHive;
  }
}
