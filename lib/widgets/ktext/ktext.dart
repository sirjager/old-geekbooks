import 'package:geeklibrary/export/export.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class KText extends StatelessWidget {
  KText(
    this.text, {
    this.size = 20,
    this.height = 1,
    this.maxLines,
    this.overflow,
    this.font = "",
    this.googleFont,
    this.letterSpacing,
    this.color,
    this.weight,
    this.enableGoogleFonts = false,
    this.textAlign,
    this.textDecoration,
    this.shadows,
  });

  @required
  final String text;
  final double size;
  final Color? color;
  final String? font;
  final int? maxLines;
  final double? height;

  final FontWeight? weight;
  final TextAlign? textAlign;
  final double? letterSpacing;
  final TextStyle? googleFont;
  final TextOverflow? overflow;
  final bool enableGoogleFonts;
  final TextDecoration? textDecoration;
  final List<Shadow>? shadows;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign ?? null,
      maxLines: maxLines,
      overflow: overflow,
      style: enableGoogleFonts
          ? (googleFont ?? GoogleFonts.poppins()).copyWith(
              color: color ?? Theme.of(context).textTheme.headline1!.color,
              fontWeight: weight ?? null,
              letterSpacing: letterSpacing ?? null,
              decoration: textDecoration ?? null,
              fontSize: size,
              height: height ?? null,
              shadows: shadows,
            )
          : TextStyle(
              color: color ?? Theme.of(context).textTheme.headline1!.color,
              fontWeight: weight ?? null,
              fontFamily: font,
              letterSpacing: letterSpacing ?? null,
              decoration: textDecoration ?? null,
              fontSize: size,
              height: height ?? null,
              shadows: shadows,
            ),
    );
  }
}
