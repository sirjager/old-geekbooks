import 'package:geekbooks/backend/functions/math/math.dart';

class IdProvider {
  List<String> idAsList(source) {
    List<String> idList = [];
    final idsExp = XMath.idsExp;
    var ids = idsExp.allMatches(source);
    for (Match id in ids) {
      idList.add(id.group(1).toString());
    }
    return idList;
  }

  static String idAsString(source) {
    String idString = "";
    String returnString = "";
    final idsExp = XMath.idsExp;
    var ids = idsExp.allMatches(source);
    for (Match id in ids) {
      idString = idString + id.group(1).toString() + ",";
    }
    returnString = idString.substring(0, idString.length - 1);
    return returnString;
  }
}