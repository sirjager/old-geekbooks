import 'package:geeklibrary/backend/functions/math/colors_genrator.dart';
import 'package:geeklibrary/export/export.dart';

class GoButton extends ConsumerWidget {
  const GoButton(
    this.info, {
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final SizingInformation info;

  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var isDarkMode = watch(themeProvider).isDarkMode;
    return KClickable(
      height: R.h(info, 4),
      width: R.w(info, 10),
      onPressed: () => onPressed(),
      child: KText(
        "go",
        size: R.f(info, 12),
        weight: FontWeight.bold,
        color: isDarkMode ? XColors.grayColor : XColors.darkColor,
      ),
      topDeco: isDarkMode
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: G.blackGradButtonDeco.gradient,
            )
          : BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                  colors: [randomLightColor(), randomLightColor()]),
            ),
      bottomDeco: isDarkMode
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient:
                  LinearGradient(colors: [Colors.black, randomLightColor()]),
            )
          : G.blackGradButtonDeco,
    );
  }
}
