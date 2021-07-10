import 'package:geekbooks/backend/crypt/cryptor.dart';
import 'package:geekbooks/export/export.dart';
import 'package:geekbooks/keys/keys.dart';
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
  final String tags;

  static EncBook buildEnc(Book data) {
    final String _key = XpKeYs.encKey;
    final _id = Encrypt.encryptAES(data.id, _key);
    final _md5 = Encrypt.encryptAES(data.md5, _key);
    final _title = Encrypt.encryptAES(data.title, _key);
    final _author = Encrypt.encryptAES(data.author, _key);
    final _series = Encrypt.encryptAES(data.series, _key);
    final _publisher = Encrypt.encryptAES(data.publisher, _key);
    final _year = Encrypt.encryptAES(data.year, _key);
    final _language = Encrypt.encryptAES(data.language, _key);
    final _pages = Encrypt.encryptAES(data.pages, _key);
    final _exten = Encrypt.encryptAES(data.exten, _key);
    final _torrent = Encrypt.encryptAES(data.torrent, _key);
    final _coverURL = Encrypt.encryptAES(data.coverURL, _key);
    final _desc = Encrypt.encryptAES(data.desc, _key);
    final _tags = Encrypt.encryptAES(data.tags, _key);

    return EncBook(
      id: _id,
      md5: _md5,
      title: _title,
      author: _author,
      series: _series,
      publisher: _publisher,
      year: _year,
      language: _language,
      pages: _pages,
      exten: _exten,
      torrent: _torrent,
      coverURL: _coverURL,
      desc: _desc,
      tags: _tags,
    );
  }

  static Book buildBook(EncBook data) {
    final String _key = XpKeYs.encKey;
    final _id = Encrypt.decryptAES(data.id, _key);
    final _md5 = Encrypt.decryptAES(data.md5, _key);
    final _title = Encrypt.decryptAES(data.title, _key);
    final _author = Encrypt.decryptAES(data.author, _key);
    final _series = Encrypt.decryptAES(data.series, _key);
    final _publisher = Encrypt.decryptAES(data.publisher, _key);
    final _year = Encrypt.decryptAES(data.year, _key);
    final _language = Encrypt.decryptAES(data.language, _key);
    final _pages = Encrypt.decryptAES(data.pages, _key);
    final _exten = Encrypt.decryptAES(data.exten, _key);
    final _torrent = Encrypt.decryptAES(data.torrent, _key);
    final _coverURL = Encrypt.decryptAES(data.coverURL, _key);
    final _desc = Encrypt.decryptAES(data.desc, _key);
    final _tags = Encrypt.decryptAES(data.tags, _key);

    return Book(
      id: _id,
      md5: _md5,
      title: _title,
      author: _author,
      series: _series,
      publisher: _publisher,
      year: _year,
      language: _language,
      pages: _pages,
      exten: _exten,
      torrent: _torrent,
      coverURL: _coverURL,
      desc: _desc,
      tags: _tags,
    );
  }
}
