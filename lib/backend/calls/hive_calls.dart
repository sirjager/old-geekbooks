import 'package:geekbooks/backend/database/hive.dart';
import 'package:geekbooks/export/export.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveCalls {
  static Future doesExist(String key) async {
    final _pageBox = await HivePageInfo.openBox("pgbox");
    final _pageInfo = await HivePageInfo.getData(_pageBox, key);
    if (_pageInfo == null) return null;
    //!========> Opening Boxes
    final _sortBox = await HiveSorts.openBox("stbox");
    final _booksBox = await HiveSorts.openBox("bkbox");

    //!========> Getting Data From Boxes
    final _sortLenks = await HiveSorts.getData(_sortBox, key);
  }

  static Future _getBooks(Box<Book> _box) async {
    
    

  }
}
