import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/utils/math/colors_genrator.dart';

class GoButton extends ConsumerWidget {
  const GoButton({Key? key, required this.onPressed}) : super(key: key);

  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var isDarkMode = watch(themeProvider).isDarkMode;
    return KClickable(
      height: 120.h,
      width: 120.w,
      onPressed: () => onPressed(),
      child: KText(
        "go",
        size: 50.sp,
        weight: FontWeight.bold,
        color: isDarkMode ? XColors.grayText : XColors.darkColor,
      ),
      topDeco: isDarkMode
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(30.w),
              gradient: G.blackGradButtonDeco.gradient,
            )
          : BoxDecoration(
              borderRadius: BorderRadius.circular(30.w),
              gradient:
                  LinearGradient(colors: [XColors.darkGray, XColors.darkGray]),
            ),
      bottomDeco: isDarkMode
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(30.w),
              gradient:
                  LinearGradient(colors: [Colors.black, randomLightColor()]),
            )
          : G.blackGradButtonDeco,
    );
  }
}
