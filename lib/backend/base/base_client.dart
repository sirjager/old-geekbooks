import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:geekbooks/backend/database/database.dart';
import 'package:geekbooks/backend/exception/exceptions.dart';
import 'package:geekbooks/core/log/log.dart';
import 'package:http/http.dart' as http;

class BaseClient {
  static const int TIMEOUT = 20;
  Future<dynamic> makeRequest(url, msg) async {
    final uri = Uri.parse(url);
    print(uri);
    final body = await SecureStorage().readStorage(uri.toString());
    if (body != null && body.length > 10) {
      //!=====> This request is already saved in Secure Storage Database
      return await _processResponse(null, url, msg, body);
    } else {
      //!=====> This request is not saved in  Secure Storage Database
      try {
        final res = await http.get(uri).timeout(Duration(seconds: TIMEOUT));
        return await _processResponse(res, url, msg, null);
      } on SocketException {
        throw BadRequestException('Bad Internet Connection', uri.toString());
      } on TimeoutException {
        throw ApiNotRespondingException('Taking a bit longer', uri.toString());
      }
    }
  }

  Future<dynamic> _processResponse(
      http.Response? response, url, msg, String? body) async {
    if (response == null) {
      if (body != null && body.toString().length > 0) {
        try {
          var json = jsonDecode(body);
          return json;
        } catch (e) {
          return body;
        }
      }
    } else {
      _print(msg, url, response, response.statusCode);
      switch (response.statusCode) {
        case 200:
          //!=======> checking if same reqst exist or not
          try {
            var json = jsonDecode(response.body);
            await SecureStorage().saveData(url, json);
            return json;
          } catch (e) {
            await SecureStorage().saveData(url, response.body);
            return response.body;
          }
        case 400:
          throw BadRequestException(utf8.decode(response.bodyBytes),
              response.request!.url.toString());
        case 401:
          throw UnAuthorizedException(utf8.decode(response.bodyBytes),
              response.request!.url.toString());
        case 404:
          throw NotFoundException(utf8.decode(response.bodyBytes),
              response.request!.url.toString());
        case 429:
          throw TooManyRequestException(utf8.decode(response.bodyBytes),
              response.request!.url.toString());
        case 500:
          throw ServerErrorException(utf8.decode(response.bodyBytes),
              response.request!.url.toString());
        default:
          throw FetchDataException(
            'Error occured with code : ${response.statusCode}',
            response.request!.url.toString(),
          );
      }
    }
  }

  void _print(msg, url, dynamic response, status) {
    log.wtf(
      "REQUEST [[$msg]] 🟣 $url\nRESPOSE [[API CALL]] 🔵 [[${response.statusCode}]] 🍀 $status",
    );
  }

  Future<String?> _checkForResponse(String url) async {
    return await SecureStorage().readStorage(url);
  }
}
