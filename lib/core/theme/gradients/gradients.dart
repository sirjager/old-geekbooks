import 'package:flutter/material.dart';

// var gradientColor = GradientTemplate.gradientTemplate[4].colors;

class GradientColors {
  final List<Color> colors;
  GradientColors(this.colors);

  static List<Color> sky = [Color(0xFF6448FE), Color(0xFF5FC6FF)];
  static List<Color> sea = [Color(0xFF61A3FE), Color(0xFF63FFD5)];
  static List<Color> fire = [Color(0xFFFF5DCD), Color(0xFFFF8484)];
  static List<Color> mango = [Color(0xFFFFA738), Color(0xFFFFE130)];
  static List<Color> flora = [Color(0xFF1d976c), Color(0xFF93f9b9)];
  static List<Color> sunset = [Color(0xFFFE6197), Color(0xFFFFB463)];
  static List<Color> forest = [Color(0xFF11998e), Color(0xFF38ef7d)];

  static List<Color> leaf = [Color(0xff08AEEA), Color(0xff2AF598)];
  static List<Color> venom = [Color(0xff21D4FD), Color(0xffB721FF)];
  static List<Color> night = [Color(0xff343A40), Color(0xff0F0F0F)];

  static List<Color> ocean = [
    Color(0xFFa6ffcb),
    Color(0xFF12d8fa),
    Color(0xFF1fa2ff),
  ];
}

class GradientTemplate {
  static List<GradientColors> gradientTemplate = [
    GradientColors(GradientColors.sky),
    GradientColors(GradientColors.sunset),
    GradientColors(GradientColors.sea),
    GradientColors(GradientColors.mango),
    GradientColors(GradientColors.fire),
    GradientColors(GradientColors.forest),
    GradientColors(GradientColors.flora),
    GradientColors(GradientColors.ocean),
    GradientColors(GradientColors.leaf),
    GradientColors(GradientColors.venom),
    GradientColors(GradientColors.night),
  ];
}
