import 'package:geeklibrary/export/export.dart';

class NextButton extends ConsumerWidget {
  const NextButton({
    Key? key,
    required this.hasNext,
    required this.onPressed,
  }) : super(key: key);

  final bool hasNext;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var isDarkMode = watch(themeProvider).isDarkMode;
    return hasNext
        ? Container(
            margin: EdgeInsets.only(right: 50.w),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(30.w),
                  child: KText(
                    "next",
                    size: 45.sp,
                    weight: FontWeight.bold,
                    color: isDarkMode ? XColors.grayText : XColors.darkColor,
                  ),
                ),
                KClickable(
                  height: 120.h,
                  width: 120.w,
                  onPressed: () => onPressed(),
                  child: Icon(
                    EvaIcons.arrowRight,
                    color: isDarkMode ? XColors.grayText : XColors.darkColor,
                  ),
                  topDeco: isDarkMode
                      ? BoxDecoration(
                          borderRadius: BorderRadius.circular(30.w),
                          gradient: G.blackGradButtonDeco.gradient,
                        )
                      : BoxDecoration(
                          borderRadius: BorderRadius.circular(30.w),
                          gradient: LinearGradient(
                              colors: [XColors.darkGray, XColors.darkGray]),
                        ),
                  bottomDeco: isDarkMode
                      ? BoxDecoration(
                          borderRadius: BorderRadius.circular(30.w),
                          gradient: LinearGradient(
                              colors: [Colors.black, randomLightColor()]),
                        )
                      : G.blackGradButtonDeco
                          .copyWith(borderRadius: BorderRadius.circular(30.w)),
                ),
              ],
            ),
          )
        : Container();
  }
}
