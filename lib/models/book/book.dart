import 'package:geekbooks/models/lenk/lenk.dart';

class Book {
  Book({
    required this.id,
    required this.md5,
    required this.title,
    required this.author,
    required this.series,
    required this.publisher,
    required this.year,
    required this.language,
    required this.pages,
    required this.exten,
    required this.torrent,
    required this.coverURL,
    required this.desc,
    required this.tags,
  });

  final String? id;
  final String? md5;
  final String? title;
  final String? author;
  final String? series;
  final String? publisher;
  final String? year;
  final String? language;
  final String? pages;
  final String? exten;
  final String? torrent;
  final String? coverURL;
  final String? desc;
  final List<String> tags;
}
