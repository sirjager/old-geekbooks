import 'package:geekbooks/backend/base/base_client.dart';
import 'package:geekbooks/backend/constants/api_strings.dart';
import 'package:geekbooks/backend/err/error_handler.dart';
import 'package:geekbooks/backend/export/backend_export.dart';
import 'package:geekbooks/backend/provider/down_provider.dart';
import 'package:geekbooks/backend/provider/page_provider.dart';
import 'package:geekbooks/backend/provider/sort_provider.dart';
import 'package:geekbooks/backend/strings/backend_strings.dart';
import 'package:geekbooks/core/log/log.dart';
import 'package:geekbooks/export/export.dart';
import 'package:geekbooks/models/download/downlenk.dart';
import 'package:geekbooks/models/lenk/lenk.dart';

import 'package:geekbooks/models/page/page.dart';
import 'package:geekbooks/models/sort/sort.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:string_validator/string_validator.dart';

class ApiCalls with ErrorHandler {
  //!==================================  [[ 1 ]]
  Future<PagePack?> getPagePack(String query, {String pageNo = "1"}) async {
    final _box = await Hive.openBox("enxpax");
    PagePack? _pagePack;
    List<Book> _books = [];
    Sort? _sort;
    PageInfo _pageInfo = PageInfo();
    final String _valid = _makeValid(query);
    final String _url = _makeURL(_valid);
    // EncPack? _encPack = _box.get(_valid);
    // if (_encPack != null) {
    //   log.i("Found $_valid Returning Saved Data");
    //   // return _encPack.pack;
    // }
    final _source = await _getSource(_url, query);
    if (_source != null) {
      final idAsString = IdProvider.idAsString(_source);
      if (idAsString.length > 0) {
        final _jsonURL = _makeJsonURL(idAsString);
        final _json = await _getJson(_jsonURL, query);
        if (_json != null) {
          _books = await _getSearchResults(_json);
          _sort = SortProvider().sortAsObject(_source);
          _pageInfo = PageProvider().pageAsObject(_source);
          _pagePack = new PagePack(
            query: query,
            books: _books,
            sort: _sort,
            info: _pageInfo,
          );
          if (_books.length > 0) {
            // EncPack _enc = EncPack(query: query, pack: _pagePack);
            // await _box.put(_valid, _enc);
            log.i("Saved $query To Hive Storage");
          }
        }
      }
    }

    return _pagePack;
  }

  //!==================================  [[ 1 ]]
  Future<dynamic> _getSource(String _uri, String msg) async {
    //!====> This Provide [[ Source ]] with {{ defaults }} for provided {{ query }}
    final bool _isURL = isURL(_uri);
    if (_isURL) {
      return await BaseClient().makeRequest(_uri, msg).catchError(handleError);
    } else
      return null;
  }

  //!==================================  [[ 3 ]]
  Future<List<Book>> _getSearchResults(json) async {
    if (json == null) return [];
    List<Book> books = await BookProvider().build(json);
    return books;
  }

  Future<Book?> getBook(String bid) async {
    //!==> This will return  [[ Book ]] as Book Object for provided bookID
    final String url =
        ApiLenks.jsonUrl + Str.ids + bid + Str.fields + Str.normalSet;
    print(url);
    var res = await BaseClient()
        .makeRequest(url, 'BOOK ID : $bid')
        .catchError(handleError);
    if (res == null) return null;
    List<Book> books = await BookProvider().build(res);
    return books.first;
  }

  Future<DownLenks?> getDownLenx(String md5, String id, String msg) async {
    //!==> This will return  [[ Downloads ]] as Download Object for provided md5
    final _url = _makeGraberURL(md5);
    final _downSource = await _getSource(_url, msg);
    if (_downSource == null) return null;
    var _lenk = Grabber.getLenks(_downSource);
    final DownLenks _downLenx = DownLenks.generate(id, md5, _lenk);
    return _downLenx;
  }

  String _makeValid(String query) => query.replaceAll(Str.space, Str.none);

  String _makeURL(String valid, {String pageNo = "1"}) =>
      ApiLenks.searchUrl + valid + Str.page + pageNo;

  String _makeGraberURL(String md5) => ApiLenks.downloadWithMd5 + md5;

  String _makeJsonURL(String ids) =>
      ApiLenks.jsonUrl + Str.ids + ids + Str.fields + Str.normalSet;

  Future<dynamic> _getJson(_jsonURL, String msg) async {
    return await BaseClient()
        .makeRequest(_jsonURL, "☁️json_results : $msg")
        .catchError(handleError);
  }
}
