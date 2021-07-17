import 'dart:math';

bool isNumeric(String string) {
  final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');
  return numericRegex.hasMatch(string);
}

String isString(String? text) {
  var string;
  if (text != null && text != "" && text != " ") {
    string = text;
  }
  return string;
}

class XUtils {
  static RegExp idsExp = new RegExp(r"title=.. id=([0-9]+)");

  bool isNumeric(String string) {
    final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');
    return numericRegex.hasMatch(string);
  }

  static String stripHtml(String text) {
    // The regular expression is simplified for an HTML tag (opening or
    // closing) or an HTML escape. We might want to skip over such expressions
    // when estimating the text directionality.
    return text.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ');
  }

  static int ranNum(int max) {
    return Random().nextInt(max);
  }
}
