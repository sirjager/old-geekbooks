import 'package:flutter/material.dart';
import 'package:geekbooks/core/responsive/builder/device_screentype.dart';
import 'package:geekbooks/core/responsive/info/sizing_info.dart';

class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({Key? key, required this.builder}) : super(key: key);
  final Widget Function(
      BuildContext context, SizingInformation sizingInformation) builder;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        var info = SizingInformation(
          orientation: mediaQuery.orientation,
          deviceType: getDeviceType(mediaQuery),
          screenSize: mediaQuery.size,
          localWidgetSize: Size(constraints.maxWidth, constraints.maxHeight),
          appbarHeight: kToolbarHeight,
          statusbarHeight: mediaQuery.padding.top,
          navbarHeight: kBottomNavigationBarHeight,
        );
        return builder(context, info);
      },
    );
  }
}
