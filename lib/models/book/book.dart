import 'package:geeklibrary/backend/constants/api_strings.dart';

class Book {
  Book({
    required this.id,
    required this.md5,
    required this.title,
    required this.author,
    required this.series,
    required this.edition,
    required this.publisher,
    required this.year,
    required this.language,
    required this.pages,
    required this.exten,
    required this.fileSize,
    required this.coverURL,
    required this.desc,
  });

  final String id;
  final String? md5;
  final String? title;
  final String? author;
  final String? series;
  final String? edition;
  final String? publisher;
  final String? year;
  final String? language;
  final String? pages;
  final String? exten;
  final String? fileSize;
  final String? coverURL;
  final String? desc;

  factory Book.build(var json) {
    return Book(
      id: json["id"] == null ? "null" : json["id"],
      md5: json["md5"] == null ? "null" : json["md5"],
      title: json["title"] == null ? "null" : json["title"],
      author: json["author"] == null ? "null" : json["author"],
      series: json["series"] == null ? "null" : json["series"],
      edition: json["edition"] == null ? "null" : json["edition"],
      publisher: json["publisher"] == null ? "null" : json["publisher"],
      year: json["year"] == null ? "null" : json["year"],
      language: json["language"] == null ? "null" : json["language"],
      pages: json["pages"] == null ? "null" : json["pages"],
      exten: json["extension"] == null ? "null" : json["extension"],
      fileSize: json["filesize"] == null ? "null" : json["filesize"],
      coverURL: json["coverurl"] == null
          ? "null"
          : json["coverurl"].toString().contains(json["md5"])
              ? ApiLenks.coverBase + json["coverurl"]
              : ApiLenks.noImage,
      desc: json["descr"] == null ? "null" : json["descr"],
    );
  }

  Book copyWith({
    String? id,
    String? md5,
    String? title,
    String? author,
    String? series,
    String? publisher,
    String? year,
    String? language,
    String? pages,
    String? exten,
    String? fileSize,
    String? coverURL,
    String? desc,
    String? tags,
  }) =>
      Book(
        id: id ?? this.id,
        md5: md5 ?? this.md5,
        title: title ?? this.title,
        author: author ?? this.author,
        series: series ?? this.series,
        edition: edition ?? this.edition,
        publisher: publisher ?? this.publisher,
        year: year ?? this.year,
        language: language ?? this.language,
        pages: pages ?? this.pages,
        exten: exten ?? this.exten,
        fileSize: fileSize ?? this.fileSize,
        coverURL: coverURL ?? this.coverURL,
        desc: desc ?? this.desc,
      );
}
