import 'package:geeklibrary/backend/crypt/cryptor.dart';
import 'package:geeklibrary/export/export.dart';
import 'package:hive/hive.dart';

part 'encbook.g.dart';

@HiveType(typeId: 2)
class EncBook extends HiveObject {
  EncBook({
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
    required this.fileSize,
    required this.coverURL,
    required this.desc,

    required this.edition,
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
  final String? fileSize;
  @HiveField(11)
  final String? coverURL;
  @HiveField(12)
  final String? desc;
  @HiveField(13)
  final String edition;

  static EncBook buildEnc(Book data) {
    var _id = Encrypt.encryptSAL(data.id);
    var _md5 = Encrypt.encryptSAL(data.md5);
    var _title = Encrypt.encryptSAL(data.title);
    var _author = Encrypt.encryptSAL(data.author);
    var _series = Encrypt.encryptSAL(data.series);
    var _edition = Encrypt.encryptSAL(data.edition);
    var _publisher = Encrypt.encryptSAL(data.publisher);
    var _year = Encrypt.encryptSAL(data.year);
    var _language = Encrypt.encryptSAL(data.language);
    var _pages = Encrypt.encryptSAL(data.pages);
    var _exten = Encrypt.encryptSAL(data.exten);
    var _fileSize = Encrypt.encryptSAL(data.fileSize);
    var _coverURL = Encrypt.encryptSAL(data.coverURL);
    var _desc = Encrypt.encryptSAL(data.desc);

    return EncBook(
      id: _id,
      md5: _md5,
      title: _title,
      author: _author,
      series: _series,
      edition: _edition,
      publisher: _publisher,
      year: _year,
      language: _language,
      pages: _pages,
      exten: _exten,
      fileSize: _fileSize,
      coverURL: _coverURL,
      desc: _desc,
    );
  }

  static Book buildBook(EncBook data) {
    var _id = Encrypt.decryptSAL(data.id);
    var _md5 = Encrypt.decryptSAL(data.md5);
    var _title = Encrypt.decryptSAL(data.title);
    var _author = Encrypt.decryptSAL(data.author);
    var _series = Encrypt.decryptSAL(data.series);
    var _edition = Encrypt.decryptSAL(data.edition);
    var _publisher = Encrypt.decryptSAL(data.publisher);
    var _year = Encrypt.decryptSAL(data.year);
    var _language = Encrypt.decryptSAL(data.language);
    var _pages = Encrypt.decryptSAL(data.pages);
    var _exten = Encrypt.decryptSAL(data.exten);
    var _fileSize = Encrypt.decryptSAL(data.fileSize);
    var _coverURL = Encrypt.decryptSAL(data.coverURL);
    var _desc = Encrypt.decryptSAL(data.desc);

    return Book(
      id: _id,
      md5: _md5,
      title: _title,
      author: _author,
      series: _series,
      edition: _edition,
      publisher: _publisher,
      year: _year,
      language: _language,
      pages: _pages,
      exten: _exten,
      fileSize: _fileSize,
      coverURL: _coverURL,
      desc: _desc,
    );
  }
}
