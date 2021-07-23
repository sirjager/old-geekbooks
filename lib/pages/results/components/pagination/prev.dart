import 'package:geeklibrary/export/export.dart';

class PreviousButton extends ConsumerWidget {
  const PreviousButton({
    Key? key,
    required this.hasPrev,
    required this.onPressed,
  }) : super(key: key);

  final bool hasPrev;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var isDarkMode = watch(themeProvider).isDarkMode;
    return hasPrev
        ? Container(
            margin: EdgeInsets.only(left: 50.w),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(30.w),
                  child: KText(
                    "previous",
                    size: 40.sp,
                    weight: FontWeight.bold,
                    color: isDarkMode ? XColors.grayText : XColors.darkColor,
                  ),
                ),
                KClickable(
                  height: 120.h,
                  width: 120.w,
                  onPressed: () => onPressed(),
                  child: Icon(
                    EvaIcons.arrowLeft,
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
