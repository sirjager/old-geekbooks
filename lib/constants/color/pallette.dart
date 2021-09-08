import 'package:geeklibrary/export/export.dart';

class XColors {
  static Color get grayColor => Color(0xff73D3BD);
  // static Color get grayColor => Color(0xffA4B5CB);
  static Color get lightGray => Color(0xffF8F8FA);
  static Color get darkGray => Color(0xffA4B5CB);
  static Color get grayText => Color(0xff94A1B6);
  static Color get grayText1 => Color(0xff696969);

  static Color get darkText => Color(0xff555555);

  static Color get deepDark => Color(0xff121313);
  static Color get darkColor => Color(0xff212020);
  static Color get darkColor1 => Color(0xff2E2E2F);
  static Color get darkColor2 => Color(0xff3E3F3E);
  static Color get darkColor3 => Color(0xff262726);
  static Color get lightColor1 => Color(0xffF8F8FA);
}

class XGradient {
  static final List<Gradient?> gradient = [
    G.blueGradient,
    G.blue2Gradient,
    G.greenGradient,
    G.green2Gradient,
    G.green3Gradient,
    G.redGradient,
    G.yellowGradient,
    G.purpleGradient,
    G.yellowGradient,
    G.pinkGradient,
    G.blackGradient,
    G.whiteGradient,
  ];
}
