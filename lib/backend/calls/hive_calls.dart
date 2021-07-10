import 'package:geekbooks/backend/database/hive.dart';
import 'package:geekbooks/models/book/encbook.dart';
import 'package:geekbooks/models/sauce/encpagesource.dart';
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
