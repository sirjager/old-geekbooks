import 'package:geekbooks/backend/base/base_client.dart';
import 'package:geekbooks/backend/constants/api_strings.dart';

import 'package:geekbooks/backend/err/error_handler.dart';
import 'package:geekbooks/backend/export/backend_export.dart';
import 'package:geekbooks/backend/provider/page_provider.dart';
import 'package:geekbooks/backend/provider/sort_provider.dart';
import 'package:geekbooks/backend/strings/backend_strings.dart';
import 'package:geekbooks/models/download/book/book.dart';

import 'package:geekbooks/models/page/page.dart';
import 'package:geekbooks/models/sort/sort.dart';
import 'package:string_validator/string_validator.dart';

class ApiCalls with ErrorHandler {
  //!==================================  [[ 1 ]]
  Future<PagePack?> getPagePack(String query, {String pageNo = "1"}) async {
    PagePack? _pagePack;
    List<Book> _books = [];
    Sort? _sort;
    PageInfo _pageInfo = PageInfo();
    final String _valid = _makeValid(query);
    final String _url = _makeURL(_valid);
    final _source = await _getSource(_url, pageNo, query);

    if (_source != null) {
      final idAsString = IdProvider.idAsString(_source);
      if (idAsString.length > 0) {
        final _jsonURL = _makeJsonURL(idAsString);
        _books = await _getSearchResults(_jsonURL, query);
        _sort = SortProvider().sortAsObject(_source);
        _pageInfo = PageProvider().pageAsObject(_source);
      }
    }

    _pagePack = new PagePack(
      query: query,
      books: _books,
      sort: _sort,
      info: _pageInfo,
    );

    if (_books.length > 0) {}

    return _pagePack;
  }

  //!==================================  [[ 1 ]]
  Future<dynamic> _getSource(String _uri, String pageNo, String msg) async {
    //!====> This Provide [[ Source ]] with {{ defaults }} for provided {{ query }}
    final bool _isURL = isURL(_uri);
    if (_isURL) {
      return await BaseClient().makeRequest(_uri, msg);
    } else
      return null;
  }

  //!==================================  [[ 3 ]]
  Future<List<Book>> _getSearchResults(_jsonURL, String msg) async {
    final json =
        await BaseClient().makeRequest(_jsonURL, "☁️json_results : $msg");
    if (json == null) return [];
    List<Book> books = await BookProvider().build(json);
    return books;
  }

  Future<Book?> getBook(String bid) async {
    //!==> This will return  [[ Book ]] as Book Object for provided bookID
    final String url =
        ApiLenks.jsonUrl + Str.ids + bid + Str.fields + Str.normalSet;
    print(url);
    var res = await BaseClient().makeRequest(url, 'BOOK ID : $bid');
    if (res == null) return null;
    List<Book> books = await BookProvider().build(res);
    return books.first;
  }

  // Future<dynamic> downloadBook(String md5) async {
  //   //!==> This will return  [[ Downloads ]] as Download Object for provided md5
  //   final String url = ApiLenks.downloadWithMd5 + md5;
  //   var res = await BaseClient().makeRequest(url, 'Download : $md5');
  //   if (res == null) return null;
  //   Downloads downloads = await Grabber().getLenks(res);
  //   return downloads;
  // }

  String _makeValid(String query) => query.replaceAll(Str.space, Str.none);

  String _makeURL(String valid, {String pageNo = "1"}) =>
      ApiLenks.searchUrl + valid + Str.page + pageNo;

  String _makeJsonURL(String ids) =>
      ApiLenks.jsonUrl + Str.ids + ids + Str.fields + Str.normalSet;
}
