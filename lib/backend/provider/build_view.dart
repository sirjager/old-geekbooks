import 'package:geeklibrary/backend/constants/api_strings.dart';
import 'package:geeklibrary/backend/export/backend_export.dart';
import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/utils/html/striphtml.dart';

class Valid {
  XMath math = XMath();
  static Future<Book> verifyBuke(Book _bok) async {
    var desc = await validateThis(_bok.desc);
    return _bok.copyWith(desc: desc);
  }

  static Future<String> validateThis(desc) async {
    var _desc = desc.toString();
    if (_desc != "null" && _desc.length > 5) {
      var _htmlFree = XUtils.stripHtml(_desc);
      var _enDesc = await checkTranslation(_htmlFree);
      if (_enDesc != null) {
        return _enDesc;
      } else {
        return _htmlFree;
      }
    } else {
      return desc;
    }
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

  static Future<String?> checkTranslation(string, {int len = 5}) async {
    try {
      var translation = await translate(string);
      return translation.text;
    } catch (e) {
      return null;
    }
  }
}
