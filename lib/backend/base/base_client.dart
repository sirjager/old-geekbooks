import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:geeklibrary/backend/exception/exceptions.dart';
import 'package:geeklibrary/core/log/log.dart';
import 'package:http/http.dart' as http;

class BaseClient {
  static const int TIMEOUT = 20;
  Future<dynamic> makeRequest(url, msg) async {
    final uri = Uri.parse(url);
    print(uri);
    //!=====> This request is not saved in  Secure Storage Database
    try {
      final res = await http.get(uri).timeout(Duration(seconds: TIMEOUT));
      return await _processResponse(res, url, msg);
    } on SocketException {
      throw BadRequestException('Bad Internet Connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('Taking a bit longer', uri.toString());
    }
  }

  Future<dynamic> _processResponse(http.Response? response, url, msg) async {
    if (response == null) return;
    switch (response.statusCode) {
      case 200:
        //!=======> checking if same reqst exist or not
        try {
          return jsonDecode(response.body);
        } catch (e) {
          return response.body;
        }
      case 400:
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 401:
        throw UnAuthorizedException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 404:
        throw NotFoundException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 429:
        throw TooManyRequestException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 500:
        throw ServerErrorException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      default:
        throw FetchDataException(
          'Error occured with code : ${response.statusCode}',
          response.request!.url.toString(),
        );
    }
  }
}
