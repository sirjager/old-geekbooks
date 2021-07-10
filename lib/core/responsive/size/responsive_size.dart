import 'package:geekbooks/core/responsive/info/sizing_info.dart';
import 'package:geekbooks/export/export.dart';

class R {
  static  double screenHeight(SizingInformation info) => info.screenSize!.height;
  static  double screenWidth(SizingInformation info) => info.screenSize!.width;
  static  double statusbarHeight(SizingInformation info) =>
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
}
