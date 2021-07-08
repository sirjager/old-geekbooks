import 'dart:ui';
import 'package:flutter/material.dart';

class KFade extends StatelessWidget {
  KFade({
    required this.child,
    this.blur = 5.0,
    this.opacity = 0.01,
    this.under,
    this.radius = 0.0,
    this.clip = Clip.antiAlias,
  });
  final double opacity;
  final Widget child;
  final double blur;
  final Widget? under;
  final double radius;
  final Clip clip;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      child: child,
      shaderCallback: (rect) {
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black,
            Colors.transparent,
          ],
        ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
      },
      blendMode: BlendMode.dstIn,
    );
  }
}
