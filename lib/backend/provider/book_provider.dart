import 'package:geekbooks/backend/constants/api_strings.dart';
import 'package:geekbooks/backend/functions/math/math.dart';
import 'package:geekbooks/backend/functions/translate/translator.dart';
import 'package:geekbooks/backend/strings/backend_strings.dart';
import 'package:geekbooks/models/download/book/book.dart';
import 'package:geekbooks/models/stock/stock.dart';

class BookProvider {
  VerifyStock v = VerifyStock();
  Future<List<Book>> build(List<dynamic> dataList) async {
    List<Stock> stockList = [];
    List<Book> bookList = [];
    if (dataList.length > 0) {
      stockList = dataList.map((single) => Stock.build(single)).toList();
    }
    for (Stock stock in stockList) {
      Book _book = await VerifyStock().verifiedStock(stock);
      bookList.add(_book);
    }
    return bookList;
  }
}

class VerifyStock {
  XMath math = XMath();
  Future<Book> verifiedStock(Stock stock) async {
    var _id = await checkString(stock.id);
    var _md5 = await checkString(stock.md5);
    var _title = await checkString(stock.title, len: 3);
    var _author =
        await checkString(stock.author, len: 3, removeThis: "(auth.)");
    var _series = await checkString(stock.series, len: 2);
    var _publisher = await checkString(stock.publisher, len: 2);
    var _year = await checkNumber(stock.year, len: 3);
    var _language = await checkString(stock.language, len: 3);
    var _pages = await checkNumber(stock.pages, len: 0);
    var _exten = await checkString(stock.exten, len: 1);
    var _torrent = await checkString(stock.torrent, len: 8);
    var _cover = await checkImageUrl(stock.coverURL, _md5);
    var _desc = await checkTranslation(stock.desc, len: 8);
    var _tags = await checkTags(stock.tags, len: 4);
    // var _downloads = await downloadBook(_md5!);

    var _book = new Book(
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
      coverURL: _cover,
      desc: _desc,
      tags: _tags,
      downloads: null,
    );
    return _book;
  }

  Future<List<String>> checkTags(string,
      {int len = 2, String split = ";"}) async {
    List<String> returnValue = [];
    if (string != null) {
      if (string.toString().length >= len) {
        var splited = string.toString().split(split);
        for (var split in splited) {
          if (split.toString().length > 3) {
            String? valdString = await checkString(split, len: 3);
            if (valdString != null) {
              var translation = await translate(split);
              returnValue.add(translation.text);
            }
          }
        }
      }
    }
    return returnValue;
  }

  Future<String?> checkString(string,
      {int len = 2, String removeThis = "", String withThis = ""}) async {
    var returnValue;
    if (string != null) {
      if (string.toString().length >= len) {
        if (string.toString() != "   ") {
          returnValue = string.toString().replaceAll(removeThis, withThis);
        }
      }
    }
    return returnValue;
  }

  Future<String?> checkNumber(string,
      {int len = 2, String removeThis = "", String withThis = ""}) async {
    var returnValue;
    if (string != null) {
      if (string.toString().length >= len) {
        if (string.toString() != "   ") {
          if (math.isNumeric(string)) {
            returnValue = string.toString().replaceAll(removeThis, withThis);
          }
        }
      }
    }
    return returnValue;
  }

  Future<String?> checkLimitAndNoSpace(string, {int limit = 6}) async {
    var returnValue;
    if (string != null) {
      if (string.toString().length >= limit) {
        if (!string.toString().contains(Str.space)) {
          returnValue = string;
        }
      }
    }
    return returnValue;
  }

  Future<String> checkImageUrl(string, String? md5, {int len = 2}) async {
    String returnValue = ApiLenks.noImage;
    if (string != null && md5 != null && md5.length > len) {
      if (string.toString().length >= len) {
        final String imageURL = ApiLenks.coverBase + string.toString();
        returnValue = imageURL;
      }
    }
    return returnValue;
  }

  Future<String?> checkTranslation(string, {int len = 5}) async {
    var returnValue;
    var strip;
    if (string != null) {
      strip = math.stripHtml(string);
    } else {}
    var validString = await checkString(strip, len: len);
    if (validString != null) {
      var translation = await translate(validString);
      var english = translation.text;
      returnValue = english;
    }
    return returnValue;
  }

  // Future<Downloads?> downloadBook(String md5) async {
  //   final url = ApiLenks.downloadWithMd5 + md5;
  //   final res = await BaseClient().makeRequest(url, md5);
  //   Downloads? downloads;
  //   if (res != null && res != "") downloads = await Grabber().getLenks(res);

  //   return downloads;
  // }
}
