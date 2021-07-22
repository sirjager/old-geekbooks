import 'package:geeklibrary/export/export.dart';

class ScreenTitlebar extends StatelessWidget {
  const ScreenTitlebar({Key? key, this.title = ""}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50.w, vertical: 50.h),
      alignment: Alignment.center,
      child: Row(
        children: [
          Consumer(
            builder: (context, watch, child) {
              var isDarkMode = watch(themeProvider).isDarkMode;
              return KText(
                title,
                font: "MavenPro",
                letterSpacing: 1,
                size: 100.sp,
                weight: FontWeight.w600,
                color: isDarkMode ? XColors.grayColor : Color(0xff555555),
              );
            },
          ),
        ],
      ),
    );
  }
}