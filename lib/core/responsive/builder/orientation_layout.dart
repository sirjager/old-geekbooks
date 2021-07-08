import 'package:flutter/material.dart';

class OrientationLayout extends StatelessWidget {
  const OrientationLayout({Key? key, required this.portrait, this.landscape})
      : super(key: key);
  final Widget? landscape;
  final Widget portrait;

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    if (orientation == Orientation.landscape) {
      return landscape ?? portrait;
    }
    return portrait;
  }
}
