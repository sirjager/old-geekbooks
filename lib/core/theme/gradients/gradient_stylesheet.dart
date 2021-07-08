import 'gradients.dart';
import 'package:flutter/material.dart';

var gradientRed = GradientTemplate.gradientTemplate[1].colors;
var gradientBlue = GradientTemplate.gradientTemplate[2].colors;
var gradientYellow = GradientTemplate.gradientTemplate[3].colors;
var gradientPink = GradientTemplate.gradientTemplate[4].colors;
var gradientGreen = GradientTemplate.gradientTemplate[5].colors;
var gradientGreen2 = GradientTemplate.gradientTemplate[6].colors;
var gradientBlue2 = GradientTemplate.gradientTemplate[7].colors;

var gradientGreen3 = GradientTemplate.gradientTemplate[8].colors;
var gradientPurple = GradientTemplate.gradientTemplate[9].colors;
var gradientBlack = GradientTemplate.gradientTemplate[10].colors;

class G {
  G._();
  static BoxDecoration inactiveGradButtonDeco = BoxDecoration(
    borderRadius: BorderRadius.circular(24),
  );

//!==================================================>      LINEAR GRADIENTS
  static LinearGradient whiteGradient = LinearGradient(
    colors: [Colors.white, Colors.white],
    end: Alignment.centerRight,
    begin: Alignment.centerLeft,
  );
  static LinearGradient redGradient = LinearGradient(
    colors: gradientRed,
    end: Alignment.centerRight,
    begin: Alignment.centerLeft,
  );
  static LinearGradient blueGradient = LinearGradient(
    colors: gradientBlue,
    end: Alignment.centerRight,
    begin: Alignment.centerLeft,
  );
  static LinearGradient yellowGradient = LinearGradient(
    colors: gradientYellow,
    end: Alignment.centerRight,
    begin: Alignment.centerLeft,
  );
  static LinearGradient pinkGradient = LinearGradient(
    colors: gradientPink,
    end: Alignment.centerRight,
    begin: Alignment.centerLeft,
  );
  static LinearGradient greenGradient = LinearGradient(
    colors: gradientGreen,
    end: Alignment.centerRight,
    begin: Alignment.centerLeft,
  );
  static LinearGradient green2Gradient = LinearGradient(
    colors: gradientGreen2,
    end: Alignment.centerRight,
    begin: Alignment.centerLeft,
  );
  static LinearGradient blue2Gradient = LinearGradient(
      colors: gradientBlue2,
      end: Alignment.bottomRight,
      begin: Alignment.topLeft,
      stops: [0.4, 0.7, 0.83]);

  static LinearGradient green3Gradient = LinearGradient(
    colors: gradientGreen3,
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static LinearGradient purpleGradient = LinearGradient(
    colors: gradientPurple,
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static LinearGradient blackGradient = LinearGradient(
    colors: gradientBlack,
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
//?==================================================>      BOX SHADOWS
  static BoxShadow whiteBoxShadow = BoxShadow(
    color: Color(0xFFFFFFFF).withOpacity(0.9),
    offset: Offset(-3, -6),
    spreadRadius: 2,
    blurRadius: 10,
  );
  static BoxShadow blackBoxShadow = BoxShadow(
    color: Color(0xFF8E8E8E).withOpacity(0.6),
    offset: Offset(3, 6),
    spreadRadius: 2,
    blurRadius: 10,
  );

  static BoxShadow redBoxShadow = BoxShadow(
    color: gradientRed.last.withOpacity(0.4),
    blurRadius: 10,
    spreadRadius: 2,
    offset: Offset(3, 6),
  );

  static BoxShadow blueBoxShadow = BoxShadow(
    color: gradientBlue.last.withOpacity(0.6),
    offset: Offset(3, 6),
    spreadRadius: 2,
    blurRadius: 10,
  );
  static BoxShadow yellowBoxShadow = BoxShadow(
    color: gradientYellow.last.withOpacity(0.4),
    blurRadius: 10,
    spreadRadius: 2,
    offset: Offset(3, 6),
  );
  static BoxShadow pinkBoxShadow = BoxShadow(
    color: gradientPink.last.withOpacity(0.4),
    blurRadius: 10,
    spreadRadius: 2,
    offset: Offset(3, 6),
  );
  static BoxShadow greenBoxShadow = BoxShadow(
    color: gradientGreen.last.withOpacity(0.4),
    blurRadius: 10,
    spreadRadius: 2,
    offset: Offset(3, 6),
  );
  static BoxShadow green2BoxShadow = BoxShadow(
    color: gradientGreen2.last.withOpacity(0.4),
    blurRadius: 10,
    spreadRadius: 2,
    offset: Offset(3, 6),
  );
  static BoxShadow blue2BoxShadow = BoxShadow(
    color: gradientBlue2.last.withOpacity(0.4),
    blurRadius: 10,
    spreadRadius: 2,
    offset: Offset(3, 6),
  );

  static BoxShadow green3BoxShadow = BoxShadow(
    color: gradientGreen3.last.withOpacity(0.8),
    offset: Offset(3, 6),
    spreadRadius: 2,
    blurRadius: 7,
  );
  static BoxShadow purpleBoxShadow = BoxShadow(
    color: gradientPurple.last.withOpacity(0.4),
    offset: Offset(3, 6),
    spreadRadius: 2,
    blurRadius: 10,
  );

  static BoxDecoration redGradButtonDeco = BoxDecoration(
    gradient: redGradient,
    boxShadow: [redBoxShadow],
    borderRadius: BorderRadius.circular(24),
  );
  static BoxDecoration blueGradButtonDeco = BoxDecoration(
    gradient: blueGradient,
    boxShadow: [blueBoxShadow],
    borderRadius: BorderRadius.circular(24),
  );
  static BoxDecoration yellowGradButtonDeco = BoxDecoration(
    gradient: yellowGradient,
    boxShadow: [yellowBoxShadow],
    borderRadius: BorderRadius.circular(24),
  );
  static BoxDecoration pinkGradButtonDeco = BoxDecoration(
    gradient: pinkGradient,
    boxShadow: [pinkBoxShadow],
    borderRadius: BorderRadius.circular(24),
  );

  static BoxDecoration green3GradButtonDeco = BoxDecoration(
    gradient: green3Gradient,
    boxShadow: [green3BoxShadow],
    borderRadius: BorderRadius.circular(24),
  );
  static BoxDecoration purpleGradButtonDeco = BoxDecoration(
    gradient: purpleGradient,
    boxShadow: [purpleBoxShadow],
    borderRadius: BorderRadius.circular(24),
  );
  static BoxDecoration blackGradButtonDeco = BoxDecoration(
    gradient: blackGradient,
    boxShadow: [blackBoxShadow],
    borderRadius: BorderRadius.circular(24),
  );
  static BoxDecoration whiteGradButtonDeco = BoxDecoration(
    gradient: whiteGradient,
    boxShadow: [whiteBoxShadow],
    borderRadius: BorderRadius.circular(24),
  );

  static BoxDecoration pinkGradBannerDeco = BoxDecoration(
    gradient: pinkGradient,
    borderRadius: BorderRadius.circular(25),
  );
  static BoxDecoration redGradBannerDeco = BoxDecoration(
    gradient: redGradient,
    borderRadius: BorderRadius.circular(25),
  );
  static BoxDecoration blueGradBannerDeco = BoxDecoration(
    gradient: blueGradient,
    borderRadius: BorderRadius.circular(25),
  );
  static BoxDecoration yellowGradBannerDeco = BoxDecoration(
    gradient: yellowGradient,
    borderRadius: BorderRadius.circular(25),
  );
  static BoxDecoration greenGradBannerDeco = BoxDecoration(
    gradient: greenGradient,
    borderRadius: BorderRadius.circular(25),
  );
  static BoxDecoration green2GradBannerDeco = BoxDecoration(
    gradient: green2Gradient,
    borderRadius: BorderRadius.circular(25),
  );
  static BoxDecoration blue2GradBannerDeco = BoxDecoration(
    gradient: blue2Gradient,
    borderRadius: BorderRadius.circular(25),
  );
  static BoxDecoration green3GradBannerDeco = BoxDecoration(
    gradient: green3Gradient,
    borderRadius: BorderRadius.circular(25),
  );
  static BoxDecoration purpleGradBannerDeco = BoxDecoration(
    gradient: purpleGradient,
    borderRadius: BorderRadius.circular(25),
  );
}
