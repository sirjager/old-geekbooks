import 'dart:ui';
import 'package:flutter/material.dart';

class KBlur extends StatelessWidget {
  KBlur({
    this.child,
    this.blur = 5.0,
    this.opacity = 0.01,
    this.under,
    this.radius = 0.0,
    this.clip = Clip.antiAlias,
    this.childAlignment = Alignment.center,
  });
  final double opacity;
  final Widget? child;
  final double blur;
  final Widget? under;
  final double radius;
  final Clip clip;
  final AlignmentGeometry childAlignment;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(radius)),
          alignment: childAlignment,
          child: under ?? Container(),
        ),
        ClipRRect(
          clipBehavior: clip,
          borderRadius: BorderRadius.circular(radius),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: blur,
              sigmaY: blur,
            ),
            child: Opacity(
              opacity: opacity,
              child: Container(
                  alignment: childAlignment, child: child ?? Text("")),
            ),
          ),
        ),
        Container(alignment: childAlignment, child: child ?? Text("")),
      ],
    );
  }
}
