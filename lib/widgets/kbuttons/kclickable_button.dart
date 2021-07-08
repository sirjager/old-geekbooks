library animated_button;

import 'package:flutter/material.dart';
import 'package:geekbooks/export/export.dart';

/// Using [ShadowDegree] with values [ShadowDegree.dark] or [ShadowDegree.light]
/// to get a darker version of the used color.
/// [duration] in milliseconds
///
class KClickable extends StatefulWidget {
  const KClickable({
    Key? key,
    required this.onPressed,
    required this.child,
    this.enabled = true,
    this.color = Colors.blue,
    this.height = 64,
    this.shadowDegree = ShadowDegree.light,
    this.width = 200,
    this.duration = 20,
    this.shape = BoxShape.rectangle,
    this.topDeco,
    this.bottomDeco,
    this.isPressed = false,
  }) : super(key: key);

  final GestureTapCallback onPressed;
  final Widget child;
  final bool enabled;
  final Color color;
  final double height;
  final double width;
  final ShadowDegree shadowDegree;
  final int duration;
  final BoxShape shape;
  final BoxDecoration? topDeco;
  final BoxDecoration? bottomDeco;
  final bool isPressed;

  @override
  _KClickableState createState() => _KClickableState();
}

class _KClickableState extends State<KClickable> {
  static const Curve _curve = Curves.easeIn;
  static const double _shadowHeight = 4;
  double _position = 4;

  @override
  Widget build(BuildContext context) {
    final double _height = widget.height - _shadowHeight;

    return GestureDetector(
      // width here is required for centering the button in parent
      child: Container(
        width: widget.width,
        height: _height + _shadowHeight,
        child: Stack(
          children: <Widget>[
            // background shadow serves as drop shadow
            // width is necessary for bottom shadow
            Positioned(
              bottom: 0,
              child: Container(
                height: _height,
                width: widget.width,
                decoration: widget.bottomDeco,
              ),
            ),
            AnimatedPositioned(
              curve: _curve,
              duration: Duration(milliseconds: widget.duration),
              bottom: widget.isPressed ? 0 : _position,
              child: Container(
                height: _height,
                width: widget.width,
                decoration: widget.topDeco,
                child: Center(
                  child: widget.child,
                ),
              ),
            ),
          ],
        ),
      ),

      onTapDown: widget.enabled ? _pressed : null,
      onTapUp: widget.enabled ? _unPressedOnTapUp : null,
      onTapCancel: widget.enabled ? _unPressed : null,
    );
  }

  void _pressed(_) {
    setState(() {
      _position = 0;
    });
  }

  void _unPressedOnTapUp(_) => _unPressed();

  void _unPressed() {
    setState(() {
      _position = 4;
    });
    widget.onPressed();
  }
}

// Get a darker color from any entered color.
// Thanks to @NearHuscarl on StackOverflow
Color darken(Color color, ShadowDegree degree) {
  double amount = degree == ShadowDegree.dark ? 0.3 : 0.12;
  final hsl = HSLColor.fromColor(color);
  final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

  return hslDark.toColor();
}

enum ShadowDegree { light, dark }
