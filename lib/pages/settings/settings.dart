import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/global/screentitle/titlebar.dart';
import 'package:geeklibrary/pages/sabed/sabed.dart';
import 'package:geeklibrary/screens/weview/kwebview.dart';
import 'package:native_admob_flutter/native_admob_flutter.dart';

class Settingspage extends StatefulWidget {
  const Settingspage({Key? key}) : super(key: key);

  @override
  _SettingspageState createState() => _SettingspageState();
}

class _SettingspageState extends State<Settingspage> {
  late final ad1;

  @override
  void initState() {
    ad1 = new BannerAdController();

    super.initState();
  }

  @override
  void dispose() {
    ad1.dispose();
    super.dispose();
  }

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
              Column(
                children: [
                  buildTile("Offline", EvaIcons.downloadOutline,
                      () => Get.to(() => SabedOffline())),
                  buildTile(
                      "Feedback",
                      LineIcons.sms,
                      () => Get.to(() => KWebView(
                          title: "Feedback", url: Googleforms.feedback))),
                  buildTile("App Info", EvaIcons.infoOutline, () {}),
                  buildTile(
                      "Contact Us",
                      EvaIcons.peopleOutline,
                      () => Get.to(() => KWebView(
                          title: "Contact", url: Googleforms.contact))),
                  buildTile(
                    "Report Bug",
                    Ionicons.bug_outline,
                    () => Get.to(() =>
                        KWebView(title: "Report Bug", url: Googleforms.bug)),
                  ),
                  buildTile(
                      "Help Center", EvaIcons.questionMarkCircleOutline, () {}),
                  buildTile("Share App", EvaIcons.shareOutline, () {}),
                  buildTile("Privacy Policy", EvaIcons.fileOutline, () {}),
                  // buildAd(100, 10, ad1),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget buildAd(double w, double h, BannerAdController ad1) {
    return ResponsiveBuilder(
      builder: (context, info) {
        return Container(
          width: R.w(info, w),
          height: R.h(info, h),
          child: BannerAd(
            controller: ad1,
            unitId: DefaultAds.bannerAdUnitId,
            error: Container(),
            loading: Container(),
            builder: (context, child) {
              return BannerAd(
                keywords: ["Education"],
                size: BannerSize(
                  Size(R.w(info, w), R.h(info, h)),
                ),
              );
            },
          ),
        );
      },
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
