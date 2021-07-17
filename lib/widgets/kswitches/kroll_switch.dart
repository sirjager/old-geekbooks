import 'package:flutter/material.dart';

class KRollSwitch extends StatefulWidget {
  const KRollSwitch({
    Key? key,
    required this.isOn,
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
    this.textOnColor = Colors.white,
    this.textOffColor = Colors.white,
    this.fontSize = 15.0,
    this.fontWeight = FontWeight.w800,
    this.duration = 600,
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
  final bool isOn;

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

  final Color textOnColor;
  final Color textOffColor;

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
  _KRollSwitchState createState() => _KRollSwitchState();
}

class _KRollSwitchState extends State<KRollSwitch> {
  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(widget.radius),
      child: AnimatedContainer(
        height: widget.height,
        width: widget.width,
        padding: EdgeInsets.symmetric(horizontal: 7.0),
        alignment: Alignment.center,
        duration: Duration(milliseconds: widget.duration),
        decoration: widget.enableGradient
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(widget.radius),
                color: widget.isOn ? widget.colorOn : widget.colorOff,
                gradient: LinearGradient(
                  colors: widget.gradient ?? [Colors.red, Colors.yellow],
                  begin: widget.begin,
                  end: widget.end,
                ),
              )
            : widget.enableBackgroundImage
                ? BoxDecoration(
                    // image: DecorationImage(
                    //   fit: widget.boxFit,
                    //   image: widget.image!,
                    // ),
                    borderRadius: BorderRadius.circular(widget.radius),
                    color: widget.isOn ? widget.colorOn : widget.colorOff,
                  )
                : BoxDecoration(
                    borderRadius: BorderRadius.circular(widget.radius),
                    color: widget.isOn ? widget.colorOn : widget.colorOff,
                  ),
        child: Stack(
          children: [
            AnimatedAlign(
              curve: Curves.easeIn,
              alignment:
                  widget.isOn ? Alignment.centerRight : Alignment.centerLeft,
              duration: Duration(milliseconds: widget.duration),
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: widget.duration),
                transitionBuilder:
                    (Widget child, Animation<double> animation) =>
                        RotationTransition(
                  child: child,
                  turns: animation,
                ),
                child: widget.isOn
                    ? Icon(
                        widget.iconOn,
                        color: widget.isOn
                            ? widget.iconOnColor
                            : widget.iconOffColor,
                        size: widget.iconSize,
                        key: UniqueKey(),
                      )
                    : Icon(
                        widget.iconOff,
                        color: widget.isOn
                            ? widget.iconOnColor
                            : widget.iconOffColor,
                        size: widget.iconSize,
                        key: UniqueKey(),
                      ),
              ),
            ),
            SizedBox(width: 2.0),
            widget.disableText
                ? Container()
                : AnimatedAlign(
                    curve: Curves.easeIn,
                    alignment: widget.isOn
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    duration: Duration(milliseconds: widget.duration),
                    child: Container(
                      padding: EdgeInsets.only(
                        right: widget.isOn ? 0.0 : 5.0,
                        left: widget.isOn ? 5.0 : 0.0,
                      ),
                      child: Text(
                        widget.isOn ? widget.textOn : widget.textOff,
                        style: TextStyle(
                          fontSize: widget.fontSize,
                          color: widget.isOn
                              ? widget.textOnColor
                              : widget.textOffColor,
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
