import 'package:geekbooks/backend/database/hive.dart';
import 'package:geekbooks/export/export.dart';
import 'package:geekbooks/models/page/pagesource.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveCalls {
  static Future<PageSource?> getHiveSauce(String key) async {
    final _pageSourceBox = await HiveSauce.openBox("source");
    final _pageSource = HiveSauce.getData(_pageSourceBox, key);
    return _pageSource;
  }

  static Future<List<Book>> getHiveBooks(List<String> idAsList) async {
    final Box<Book> _box = await HiveBooks.openBox("books");
    List<Book> _booksFromHive = [];
    for (String id in idAsList) {
      Book? _book = await HiveBooks.getData(_box, id);
      if (_book != null) {
        _booksFromHive.add(_book);
      }
    }
    return _booksFromHive;
  }
}
