import 'package:geeklibrary/core/responsive/info/sizing_info.dart';
import 'package:geeklibrary/export/export.dart';
import 'dart:math' as math;

class R {
  static double screenHeight(SizingInformation info) => info.screenSize!.height;
  static double screenWidth(SizingInformation info) => info.screenSize!.width;
  static double statusbarHeight(SizingInformation info) =>
      info.statusbarHeight!;
  static double get navbarHeight => kBottomNavigationBarHeight;
  static double get appbarHeight => kToolbarHeight;

  static double h(SizingInformation info, h) =>
      (info.screenSize!.height / 100) * h;

  static double w(SizingInformation info, w) =>
      (info.screenSize!.width / 100) * w;

  static double f(SizingInformation info, f) {
    if (info.orientation == Orientation.landscape)
      return (info.screenSize!.height / 100) * (f / 3);
    return (info.screenSize!.width / 100) * (f / 3);
  }

  static double r(SizingInformation info, int percent) {
    var height = math.pow(info.screenSize!.height, 2);
    var width = math.pow(info.screenSize!.width, 2);
    var hypo = math.sqrt(height + width);
    return (hypo / 100) * percent / 3;
  }
}
