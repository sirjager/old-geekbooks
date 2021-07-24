import 'package:flutter/material.dart';
import 'package:geeklibrary/core/responsive/builder/responsive_builder.dart';
import 'package:geeklibrary/core/responsive/enum/device_screen_type.dart';

class ScreenLayout extends StatelessWidget {
  const ScreenLayout({
    Key? key,
    required this.mobile,
    this.tablet,
    this.desktop,
  }) : super(key: key);

  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, deviceInfo) {
      if (deviceInfo.deviceType == DeviceScreenType.Tablet) {
        return tablet ?? mobile;
      }
      if (deviceInfo.deviceType == DeviceScreenType.Desktop) {
        return desktop ?? mobile;
      }

      return mobile;
    });
  }
}
