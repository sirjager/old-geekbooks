import 'package:flutter/material.dart';

class KLeafButton extends StatefulWidget {
  const KLeafButton({
    Key? key,

    //
    required this.onPressed,
    this.shadowSpread = 2,
    this.shadowColor,
    this.blurRadius = 10,
    this.shadowX = 1,
    this.shadowY = 10,
    this.enabled = true,
    this.shadowDegree = ShadowDegree.light,
    this.duration = 70,
    //
    this.icon = Icons.home,
    this.width,
    required this.height,
    this.iconSize,
    this.child,
    this.iconColor,
    //
    this.radius = 20,
    this.gradient,
    this.disableShadow = false,
    this.enableGradient = false,
    this.color2 = Colors.white,
    this.color1 = Colors.greenAccent,
  }) : super(key: key);

  final double shadowSpread;
  final Color? shadowColor;
  final double blurRadius;
  final double shadowX;
  final double shadowY;
  final bool enabled;
  final int duration;
  final ShadowDegree shadowDegree;
  final GestureTapCallback onPressed;

  final double height;
  final double? width;
  final Widget? child;
  final IconData icon;
  final Color? iconColor;
  final double? iconSize;

  final Color color1;
  final Color color2;
  final double radius;
  final bool disableShadow;
  final bool enableGradient;
  final LinearGradient? gradient;

  @override
  _KLeafButtonState createState() => _KLeafButtonState();
}

class _KLeafButtonState extends State<KLeafButton> {
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
    double _width = widget.height * 2;
    final double _height = widget.height - _shadowHeight;

    return GestureDetector(
      child: Container(
        width: widget.width ?? _width,
        height: _height + _shadowHeight,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: Container(
                height: _height,
                width: widget.width ?? _width,
                decoration: BoxDecoration(
                  color: widget.enabled
                      ? darken(
                          widget.enableGradient == true
                              ? widget.gradient != null
                                  ? widget.gradient!.colors.first
                                  : widget.color1
                              : widget.color1,
                          widget.shadowDegree,
                        )
                      : darken(Colors.grey, widget.shadowDegree),
                  borderRadius: BorderRadius.circular(widget.radius * 50),
                ),
              ),
            ),
            AnimatedPositioned(
              curve: _curve,
              bottom: _position,
              duration: Duration(milliseconds: widget.duration),
              child: Container(
                height: _height,
                width: widget.width ?? _width,
                decoration: BoxDecoration(
                  color: widget.color2,
                  borderRadius: BorderRadius.circular(widget.radius * 50),
                  boxShadow: widget.disableShadow
                      ? null
                      : _position != 0
                          ? [
                              BoxShadow(
                                blurRadius: widget.blurRadius,
                                spreadRadius: widget.shadowSpread,
                                color: Colors.black12,
                                offset: Offset(widget.shadowX, widget.shadowY),
                              ),
                            ]
                          : null,
                ),
                child: Row(
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: widget.duration),
                      width: (widget.width ?? _width) -
                          ((widget.iconSize ?? widget.width ?? _width) / 5) -
                          (widget.width ?? _width) * 0.05,
                      height: widget.height,
                      padding: EdgeInsets.symmetric(
                          horizontal: (widget.width ?? _width) * 0.10,
                          vertical: widget.height * 0.10),
                      alignment: Alignment.center,
                      child: widget.child ?? Text("Button"),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(widget.radius * 50),
                          topLeft: Radius.circular(widget.radius * 50),
                          bottomRight: Radius.circular(widget.radius * 100),
                          topRight: Radius.circular(widget.radius * 5),
                        ),
                        color: widget.color1,
                        gradient: widget.enableGradient
                            ? widget.gradient == null
                                ? LinearGradient(
                                    colors: [widget.color1, widget.color2],
                                  )
                                : widget.gradient
                            : LinearGradient(
                                colors: [widget.color1, widget.color1],
                              ),
                      ),
                    ),
                    Padding(
                      padding: widget.radius == 0
                          ? EdgeInsets.only(
                              right: (widget.width ?? _width) * 0.020,
                              left: (widget.width ?? _width) * 0.020)
                          : EdgeInsets.only(
                              right: (widget.width ?? _width) * 0.05),
                      child: Icon(
                        widget.icon,
                        size: widget.iconSize != null
                            ? widget.iconSize
                            : (widget.width ?? _width) / 5,
                        color: widget.iconColor == null
                            ? widget.gradient != null
                                ? widget.gradient!.colors.first
                                : widget.color1
                            : widget.iconColor,
                      ),
                    )
                  ],
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

Color darken(Color color, ShadowDegree degree) {
  double amount = degree == ShadowDegree.dark ? 0.3 : 0.12;
  final hsl = HSLColor.fromColor(color);
  final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

  return hslDark.toColor();
}

enum ShadowDegree { light, dark }
