import 'package:geeklibrary/core/responsive/enum/device_screen_type.dart';
import 'package:geeklibrary/export/export.dart';

DeviceScreenType getDeviceType(MediaQueryData mediaQuery) {
  double deviceWidth = mediaQuery.size.shortestSide;
  if (deviceWidth > 900) {
    return DeviceScreenType.Desktop;
  }
  if (deviceWidth > 600) {
    return DeviceScreenType.Tablet;
  }
  return DeviceScreenType.Mobile;
}
