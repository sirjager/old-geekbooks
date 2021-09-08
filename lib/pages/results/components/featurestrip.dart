import 'package:geeklibrary/export/export.dart';

class FeatureStrip extends ConsumerWidget {
  const FeatureStrip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var theme = watch(themeProvider);
    var blackwhite = watch(blackNWhiteProvider);
    return Container(
      height: 60.h,
      margin: EdgeInsets.only(top: 5.h, bottom: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 50.w),
      alignment: Alignment.center,
      color: theme.isDarkMode ? XColors.darkColor2 : XColors.darkGray,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          KText(
            "Make cover images darker",
            googleFont: GoogleFonts.poppins(),
            size: 35.sp,
            weight: FontWeight.bold,
            color: theme.isDarkMode ? XColors.grayColor : Colors.black,
          ),
          SizedBox(width: 40.w),
          Switch.adaptive(
            onChanged: (bool value) => blackwhite.setBlackNWhite(value),
            value: blackwhite.blackNWhite,
          ),
        ],
      ),
    );
  }
}
