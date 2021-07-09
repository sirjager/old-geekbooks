import 'package:geekbooks/export/export.dart';
import 'package:geekbooks/models/page/page.dart';
import 'package:geekbooks/models/sort/sort.dart';

class PagePack {
  PagePack({
    required this.query,
    required this.books,
    required this.sort,
    required this.info,
  });

  final String query;
  final Sort? sort;
  final List<Book> books;
  final PageInfo info;
}
