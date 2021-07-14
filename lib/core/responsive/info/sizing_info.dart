import 'package:geeklibrary/core/responsive/enum/device_screen_type.dart';
import 'package:geeklibrary/export/export.dart';

class SizingInformation {
  final Orientation? orientation;
  final DeviceScreenType? deviceType;
  final Size? screenSize;
  final Size? localWidgetSize;
  final double? navbarHeight;
  final double? statusbarHeight;
  final double? appbarHeight;

  SizingInformation({
    this.orientation,
    this.deviceType,
    this.screenSize,
    this.localWidgetSize,
    this.appbarHeight,
    this.navbarHeight,
    this.statusbarHeight,
  });

  @override
  String toString() {
    return "Orientation:$orientation, DeviceType:$deviceType, ScreenSize:$screenSize, LocalWidgetSize:$localWidgetSize";
  }
}
