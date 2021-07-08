import 'package:flutter/foundation.dart';
import 'package:geekbooks/backend/constants/api_strings.dart';
import 'package:geekbooks/backend/export/backend_export.dart';
import 'package:geekbooks/export/export.dart';

class Result {
  Result({
    @required this.id,
    @required this.title,
    @required this.author,
    @required this.coverUrl,
  });
  final String? id;
  final String? title;
  final String? author;
  final String? coverUrl;

  factory Result.build(var json) => Result(
        id: json['id'] == null ? null : json['id'],
        title: json['title'] == null ? null : json['title'],
        author: json['author'] == null
            ? null
            : json['author'].toString().replaceAll(Str.auth, Str.none),
        coverUrl: json['coverurl'].toString() == "" || json['coverurl'] == null
            ? null
            : ApiLenks.coverBase + json['coverurl'].toString(),
      );
}
