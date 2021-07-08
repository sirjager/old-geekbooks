import 'package:geekbooks/models/download/book/book.dart';
import 'package:geekbooks/models/sort/sort.dart';

class PageInfo {
  PageInfo({
    this.totalFiles,
    this.totalPages,
    this.pagesVisible,
    this.currentPage,
    this.sortSample,
    this.showingResultsFrom,
    this.showingResultsTo,
    this.currentPageUrl,
  });
  final String? currentPageUrl;
  final String? totalFiles;
  final String? totalPages;
  final String? pagesVisible;
  final String? currentPage;
  final String? sortSample;
  final String? showingResultsFrom;
  final String? showingResultsTo;
}

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
