import 'package:flutter/material.dart';

class KSimpleSwitch extends StatefulWidget {
  const KSimpleSwitch({
    Key? key,
    required this.onTap,
    required this.toggle,
    this.iconSize = 30.0,
    this.iconOn = Icons.alarm_add_rounded,
    this.iconOff = Icons.alarm_off_rounded,
    this.iconOnColor = Colors.white,
    this.iconOffColor = Colors.white,
    this.radius = 20.0,
    this.colorOn = Colors.greenAccent,
    this.colorOff = Colors.redAccent,
    this.disableText = false,
    this.textOn = 'on',
    this.textOff = 'off',
    this.fontOnColor = Colors.white,
    this.fontOffColor = Colors.white,
    this.fontSize = 15.0,
    this.fontWeight = FontWeight.w800,
    this.duration = 375,
    this.height = 40.0,
    this.width = 85.0,
    this.image,
    this.boxFit = BoxFit.cover,
    this.enableBackgroundImage = false,
    this.gradient,
    this.enableGradient = false,
    this.begin = Alignment.topLeft,
    this.end = Alignment.bottomRight,
  }) : super(key: key);

  final bool toggle;
  final Function? onTap;
  final IconData iconOn;
  final IconData iconOff;
  final double iconSize;

  final Color iconOnColor;
  final Color iconOffColor;

  final Color colorOn;
  final Color colorOff;
  final double radius;

  final bool disableText;
  final String textOn;
  final String textOff;

  final Color fontOnColor;
  final Color fontOffColor;

  final double fontSize;
  final FontWeight fontWeight;

  final int duration;

  final double height;
  final double width;

  final List<Color>? gradient;
  final bool enableGradient;
  final AlignmentGeometry begin;
  final AlignmentGeometry end;

  final BoxFit boxFit;
  final ImageProvider? image;
  final bool enableBackgroundImage;

  @override
  _KSimpleSwitchState createState() => _KSimpleSwitchState();
}

class _KSimpleSwitchState extends State<KSimpleSwitch> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onTap,
      child: AnimatedContainer(
        height: widget.height,
        width: widget.width,
        padding: EdgeInsets.symmetric(horizontal: 7.0),
        alignment: Alignment.center,
        duration: Duration(milliseconds: widget.duration),
        decoration: widget.enableGradient
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(widget.radius),
                color: widget.toggle ? widget.colorOn : widget.colorOff,
                gradient: LinearGradient(
                  colors: widget.gradient ?? [Colors.red, Colors.yellow],
                  begin: widget.begin,
                  end: widget.end,
                ),
              )
            : widget.enableBackgroundImage
                ? BoxDecoration(
                    // image: DecorationImage(
                    //     fit: widget.boxFit, image: widget.image),
                    borderRadius: BorderRadius.circular(widget.radius),
                    color: widget.toggle ? widget.colorOn : widget.colorOff,
                  )
                : BoxDecoration(
                    borderRadius: BorderRadius.circular(widget.radius),
                    color: widget.toggle ? widget.colorOn : widget.colorOff,
                  ),
        child: Stack(
          children: [
            AnimatedAlign(
              curve: Curves.easeIn,
              alignment:
                  widget.toggle ? Alignment.centerRight : Alignment.centerLeft,
              duration: Duration(milliseconds: widget.duration),
              child: Icon(
                widget.toggle ? widget.iconOn : widget.iconOff,
                color: widget.toggle ? widget.iconOnColor : widget.iconOffColor,
                size: widget.iconSize,
              ),
            ),
            SizedBox(width: 2.0),
            widget.disableText
                ? Container()
                : AnimatedAlign(
                    curve: Curves.easeIn,
                    alignment: widget.toggle
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    duration: Duration(milliseconds: widget.duration),
                    child: Container(
                      padding: EdgeInsets.only(
                        right: widget.toggle ? 0.0 : 5.0,
                        left: widget.toggle ? 5.0 : 0.0,
                      ),
                      child: Text(
                        widget.toggle
                            ? widget.toggle.toString()
                            : widget.toggle.toString(),
                        style: TextStyle(
                          fontSize: widget.fontSize,
                          color: widget.toggle
                              ? widget.fontOnColor
                              : widget.fontOffColor,
                          fontWeight: widget.fontWeight,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
