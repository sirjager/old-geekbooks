import 'package:geekbooks/backend/base/base_client.dart';
import 'package:geekbooks/backend/calls/encryption.dart';
import 'package:geekbooks/backend/calls/hive_calls.dart';
import 'package:geekbooks/backend/constants/api_strings.dart';
import 'package:geekbooks/backend/database/hive.dart';
import 'package:geekbooks/backend/err/error_handler.dart';
import 'package:geekbooks/backend/export/backend_export.dart';
import 'package:geekbooks/backend/provider/down_provider.dart';
import 'package:geekbooks/backend/provider/page_provider.dart';
import 'package:geekbooks/backend/provider/sort_provider.dart';
import 'package:geekbooks/backend/strings/backend_strings.dart';
import 'package:geekbooks/core/log/log.dart';
import 'package:geekbooks/export/export.dart';
import 'package:geekbooks/models/book/encbook.dart';
import 'package:geekbooks/models/download/downlenk.dart';
import 'package:geekbooks/models/page/page.dart';
import 'package:geekbooks/models/sauce/encpagesource.dart';
import 'package:geekbooks/models/sauce/pagesource.dart';
import 'package:geekbooks/models/sort/sort.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:string_validator/string_validator.dart';

class ApiCalls with ErrorHandler {
  //!==================================  [[ 1 ]]
  Future<PagePack?> getPagePack(String query, {String pageNo = "1"}) async {
    PagePack? _pagePack;
    List<Book> _books = [];
    Sort? _sort;
    PageInfo _pageInfo = PageInfo();
    final Box<EncBook> _encBooksBox = await HiveEncBooks.openBox("encbooks");
    final Box<EncPageSource> _encSauceBox = await HiveSauce.openBox("source");
    final String _valid = _makeValid(query);
    final String _url = _makeURL(_valid);
    /* Checking if Same Request if saved in local database or not.
        If Request is Found in database -----> Source is returned from Database
        IF Request is Not Found in database -----> Source is fetched from Internet */
    final _hiveSource = await HiveCalls.getHiveSauce(_valid);
    final PageSource? _decSauce = _decryptSauce(_hiveSource);
    dynamic _source;

    if (_decSauce != null &&
        _decSauce.key == _valid &&
        _decSauce.source != null) {
      // Instance of Pagesource should containt non null source and match the request
      _source = _decSauce.source;
      log.e("Source Found For $_valid");
    } else {
      //---> Source being fetched from Internet
      _source = await _getSource(_url, query);
      if (_source != null && _source.toString().length > 50) {
        //--> After Source is fetched from internet then source is saved in local Database with Request as a Key
        final EncPageSource _encSauce = _encPageSource(_source);
        await HiveSauce.putData(_encSauceBox, _valid, _encSauce);
        log.w("Saved New Source For $_valid");
      }
    }
    //----> Origin of source is decided above
    //----> Source is checked here if its valid and should have more than 100 Characters
    if (_source != null && _source.toString().length > 100) {
      //------> All the IDS are EXTRACTED from the SOURCE --- as STRING
      final idAsString = IdProvider.idAsString(_source);
      if (idAsString.length > 0) {
        //------> All the IDS are EXTRACTED from the SOURCE --- as LIST of IDs
        final _idList = _idAsList(idAsString);
        //--- For Every ID
        final List<EncBook> _booksFromHive =
            await HiveCalls.getHiveBooks(_encBooksBox, _idList);
        if (_booksFromHive.length == _idList.length) {
          //! Fetching Books from Local Database
          List<EncBook> _encBooks = _booksFromHive;
          _books = _getDecryptedBooks(_encBooks);
          log.w("Books Found");
        } else {
          //! Fetching Books from internet
          final _jsonURL = _makeJsonURL(idAsString);
          final _json = await _getJson(_jsonURL, query);
          if (_json != null) {
            _books = _getSearchResults(_json);
            final List<EncBook> _encBooks = _getEncryptedBooks(_books);
            for (int i = 0; i < _encBooks.length; i++) {
              await _encBooksBox.put(_books[i].id, _encBooks[i]);
            }
          }
        }
        _sort = SortProvider().sortAsObject(_source);
        _pageInfo = PageProvider().pageAsObject(_source);
        _pagePack = new PagePack(
          query: query,
          books: _books,
          sort: _sort,
          info: _pageInfo,
        );
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
  List<Book> _getSearchResults(json) {
    if (json == null) return [];
    List<Book> books = BookProvider().build(json);
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
    List<Book> books = BookProvider().build(res);
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

  String _makeValid(String query) => query.replaceAll(Str.space, Str.plus);

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

  List<String> _idAsList(String idAsString) =>
      idAsString.split(Str.coma).toList();

  List<Book> _getDecryptedBooks(List<EncBook> _encBooks) {
    List<Book> _books = [];
    print("\nDecrypting All Bukes ...\n");
    for (EncBook enc in _encBooks) {
      Book _dec = CryptionCalls.decryptBok(enc);
      _books.add(_dec);
    }
    return _books;
  }

  List<EncBook> _getEncryptedBooks(List<Book> _books) {
    List<EncBook> _encBooks = [];
    print("\nEncrypting All Bukes ...\n");
    for (Book bok in _books) {
      EncBook _enc = CryptionCalls.encryptBok(bok);
      _encBooks.add(_enc);
    }
    return _encBooks;
  }

  PageSource? _decryptSauce(EncPageSource? hiveSource) {
    if (hiveSource != null) {
      print("\nDecrypting PageSauce ...\n");
      return CryptionCalls.decryptSauce(hiveSource);
    }
    return null;
  }

  EncPageSource _encPageSource(source) {
    print("\nEncrypting PageSauce ...\n");
    return CryptionCalls.encryptSauce(source);
  }
}
