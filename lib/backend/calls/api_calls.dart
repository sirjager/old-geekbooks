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
  Future<String?> getSource(String query, {String pageNo = "1"}) async {
    //!====> This Provide [[ Source ]] with {{ defaults }} for provided {{ query }}
    final _validQuery =
        query.toLowerCase().toString().replaceAll(Str.space, Str.plus);
    final String _uri = ApiLenks.searchUrl + _validQuery + Str.page + pageNo;
    final bool _isURL = isURL(_uri);
    if (_isURL) {
      final _source = await BaseClient().makeRequest(_uri, query);
      return _source;
    } else
      return null;
  }

  Future<PagePack> getPagePack(String query, {String pageNo = "1"}) async {
    PagePack? pagePack;
    List<Result> results = [];
    Sort? sort;
    PageInfo info;
    final source = await getSource(query, pageNo: pageNo);

    if (source != null) {
      final idAsString = await getIDSFromSource(source);
      if (idAsString != null) {
        results = await getSearchResults(idAsString);
      } else {}
      sort = await SortProvider().sortAsObject(source);
      info = (await PageProvider().pageAsObject(source))!;
    } else {
      info = PageInfo();
    }

    pagePack = new PagePack(
      query: query,
      books: results,
      sort: sort,
      info: info,
    );

    return pagePack;
  }

  Future<List<Result>> getSearchResults(ids) async {
    final String url =
        ApiLenks.jsonUrl + Str.ids + ids + Str.fields + Str.minimalSet;
    final json = await BaseClient().makeRequest(url, "");
    if (json == null) return [];
    dynamic jsonList = json;
    List<dynamic> resultsAsJson = jsonList;
    List<Result> results = resultsAsJson.map((r) => Result.build(r)).toList();
    return results;
  }

  Future<dynamic> getIDSFromSource(source) async {
    //!==> This will return all [[ IDS ]] as String seperated by comma(,) for provided Query
    if (source == null) return;
    var ids = await IdProvider.idAsString(source);
    return ids;
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
}
