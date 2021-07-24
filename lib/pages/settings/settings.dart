import 'package:geeklibrary/constants/forms/links.dart';
import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/global/screentitle/titlebar.dart';
import 'package:geeklibrary/screens/weview/kwebview.dart';

class Settingspage extends StatelessWidget {
  const Settingspage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        buildShapes(),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
          child: Column(
            children: [
              ScreenTopbar(),
              ScreenTitlebar(title: "Settings"),
              SizedBox(height: 50.h),
              buildTile("Offline", EvaIcons.downloadOutline, () {}),
              buildTile("Feedback", LineIcons.sms,
                  () => Get.to(KWebView(url: Googleforms.feedback))),
              buildTile("App Info", EvaIcons.infoOutline, () {}),
              buildTile("Contact Us", EvaIcons.peopleOutline, () {}),
              buildTile("Report Bug", Ionicons.bug_outline, () {}),
              buildTile(
                  "Help Center", EvaIcons.questionMarkCircleOutline, () {}),
              buildTile("Share App", EvaIcons.shareOutline, () {}),
              buildTile("Privacy Policy", EvaIcons.fileOutline, () {}),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildShapes() {
    return Consumer(
      builder: (context, watch, child) {
        var isDarkMode = watch(themeProvider).isDarkMode;
        return Container(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 0,
                left: 0,
                child: Image.asset(
                  "assets/images/shapes/main_top.png",
                  width: 500.w,
                  color: isDarkMode
                      ? Colors.white.withOpacity(0.07)
                      : Colors.red.withOpacity(0.1),
                ),
              ),
              AnimatedPositioned(
                bottom: isDarkMode ? 0 : 1800.h,
                left: isDarkMode ? 0 : 800.w,
                curve: Curves.fastOutSlowIn,
                duration: Duration(seconds: 3),
                child: AnimatedContainer(
                  curve: Curves.fastOutSlowIn,
                  duration: Duration(seconds: 2),
                  height: isDarkMode ? 350.w : 400.w,
                  width: isDarkMode ? 350.w : 400.w,
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? Colors.white.withOpacity(0.05)
                        : Colors.amber.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildTile(String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: () => onTap(),
      borderRadius: BorderRadius.circular(20.w),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 50.w),
            padding: EdgeInsets.all(45.w),
            child: Consumer(
              builder: (context, watch, child) {
                var isDarkMode = watch(themeProvider).isDarkMode;
                return Row(
                  children: [
                    Icon(
                      icon,
                      size: 80.sp,
                      color: isDarkMode ? XColors.grayColor : Color(0xff555555),
                    ),
                    SizedBox(width: 50.w),
                    KText(
                      title,
                      font: "Nunito",
                      size: 60.sp,
                      weight: FontWeight.w400,
                      color: isDarkMode ? XColors.grayColor : Color(0xff555555),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
