import 'package:geekbooks/backend/database/hive.dart';
import 'package:geekbooks/backend/export/backend_export.dart';
import 'package:geekbooks/export/export.dart';
import 'package:geekbooks/models/page/pagesource.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveCalls {
  static Future<PageSource?> getHiveSauce(String key) async {
    final _pageSourceBox = await HiveSauce.openBox("source");
    final _pageSource = HiveSauce.getData(_pageSourceBox, key);
    return _pageSource;
  }

  static Future<List<Book>> getHiveBooks(String idAsString) async {
    final Box<Book> _box = await HiveBooks.openBox("boox");
    final idsList = idAsString.split(Str.coma).toList();
    List<Book> _booksFromHive = [];
    for (String id in idsList) {
      Book? _book = await HiveBooks.getData(_box, id);
      if (_book != null) _booksFromHive.add(_book);
    }
    return _booksFromHive;
  }
}
