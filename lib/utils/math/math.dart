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

class XMath {
  static RegExp idsExp = new RegExp(r"title=.. id=([0-9]+)");

  bool isNumeric(String string) {
    final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');
    return numericRegex.hasMatch(string);
  }

  String stripHtml(String text) {
    // The regular expression is simplified for an HTML tag (opening or
    // closing) or an HTML escape. We might want to skip over such expressions
    // when estimating the text directionality.
    return text.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ');
  }

  static int ranNum(int max) {
    return Random().nextInt(max);
  }

  static String convertBytesToMB(bytes, {int precision = 2}) {
    return ((int.parse(bytes) / 1024) / 1024).toStringAsPrecision(precision);
  }
}
