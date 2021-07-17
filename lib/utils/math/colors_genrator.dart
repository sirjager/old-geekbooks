import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:geeklibrary/core/theme/palette/colors.dart';

final rnd = math.Random();
Color randomColor() => Color(rnd.nextInt(0xffffffff));
Color randomLightColor() => lightColors[rnd.nextInt(lightColors.length)];
