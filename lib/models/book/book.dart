import 'package:geekbooks/backend/constants/api_strings.dart';
import 'package:hive/hive.dart';
part 'book.g.dart';

@HiveType(typeId: 2)
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

  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? md5;
  @HiveField(2)
  final String? title;
  @HiveField(3)
  final String? author;
  @HiveField(4)
  final String? series;
  @HiveField(5)
  final String? publisher;
  @HiveField(6)
  final String? year;
  @HiveField(7)
  final String? language;
  @HiveField(8)
  final String? pages;
  @HiveField(9)
  final String? exten;
  @HiveField(10)
  final String? torrent;
  @HiveField(11)
  final String? coverURL;
  @HiveField(12)
  final String? desc;
  @HiveField(13)
  final List<String>? tags;

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
              : null,
      tags: json["tags"] == null
          ? null
          : json["tags"].toString().split(",").toList(),
      desc: json["descr"] == null ? null : json["descr"],
    );
  }
}
