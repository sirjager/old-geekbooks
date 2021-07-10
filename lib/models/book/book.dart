import 'package:geekbooks/backend/constants/api_strings.dart';
import 'package:hive/hive.dart';

class Book extends HiveObject {
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
  final String? tags;

  factory Book.build(var json) {
    return Book(
      id: json["id"] == null ? null : json["id"],
      md5: json["md5"] == null ? null : json["md5"],
      title: json["title"] == null ? null : json["title"],
      author: json["author"] == null ? null : json["author"],
      series: json["series"] == null ? null : json["series"],
      publisher: json["publisher"] == null ? null : json["publisher"],
      year: json["year"] == null ? null : json["year"],
      language: json["language"] == null ? null : json["language"],
      pages: json["pages"] == null ? null : json["pages"],
      exten: json["extension"] == null ? null : json["extension"],
      torrent: json["torrent"] == null ? null : json["torrent"],
      coverURL: json["coverurl"] == null
          ? null
          : json["coverurl"].toString().contains(json["md5"])
              ? ApiLenks.coverBase + json["coverurl"]
              : ApiLenks.noImage,
      tags: json["tags"] == null ? null : json["tags"],
      desc: json["descr"] == null ? null : json["descr"],
    );
  }
}
