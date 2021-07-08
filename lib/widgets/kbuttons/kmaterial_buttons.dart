library animated_button;

import 'package:flutter/material.dart';

/// Using [ShadowDegree] with values [ShadowDegree.dark] or [ShadowDegree.light]
/// to get a darker version of the used color.
/// [duration] in milliseconds
///
class KMaterialButton extends StatefulWidget {
  const KMaterialButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.enabled = true,
    this.color = Colors.blue,
    this.height = 50,
    this.shadowDegree = ShadowDegree.light,
    this.width = 100,
    this.duration = 70,
    this.radius = 20,
    this.enableGradient = false,
    this.disableShadow = false,
    this.shape = BoxShape.rectangle,
    this.gradient,
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
  final double radius;
  final bool enableGradient;
  final LinearGradient? gradient;
  final bool disableShadow;

  @override
  _KMaterialButtonState createState() => _KMaterialButtonState();
}

class _KMaterialButtonState extends State<KMaterialButton> {
  static const Curve _curve = Curves.easeIn;
  static const double _shadowHeight = 4;
  double _position = 4;

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double _height = widget.height - _shadowHeight;

    return GestureDetector(
      // width here is required for centering the button in parent
      child: Container(
        width: widget.width,
        height: _height + _shadowHeight,
        child: Stack(
          children: [
            // background shadow serves as drop shadow
            // width is necessary for bottom shadow
            Positioned(
              bottom: 0,
              child: Container(
                height: _height,
                width: widget.width,
                decoration: BoxDecoration(
                  color: widget.enabled
                      ? darken(
                          widget.gradient != null
                              ? widget.gradient!.colors.first
                              : widget.color,
                          widget.shadowDegree)
                      : darken(Colors.grey, widget.shadowDegree),
                  borderRadius: widget.shape != BoxShape.circle
                      ? BorderRadius.circular(widget.radius)
                      : null,
                  shape: widget.shape,
                ),
              ),
            ),
            AnimatedPositioned(
              curve: _curve,
              duration: Duration(milliseconds: widget.duration),
              bottom: _position,
              child: Container(
                height: _height,
                width: widget.width,
                decoration: BoxDecoration(
                  color: widget.enabled ? widget.color : Colors.grey,
                  borderRadius: widget.shape != BoxShape.circle
                      ? BorderRadius.circular(widget.radius)
                      : null,
                  shape: widget.shape,
                  gradient: !widget.enabled
                      ? null
                      : widget.enableGradient
                          ? (widget.gradient != null
                              ? widget.gradient
                              : LinearGradient(
                                  colors: [
                                    widget.color
                                        .withBlue(0)
                                        .withRed(0)
                                        .withGreen(0)
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ))
                          : null,
                ),
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
