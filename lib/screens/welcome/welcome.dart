import 'package:geeklibrary/backend/dialog/dialog.dart';
import 'package:geeklibrary/core/dialog/dialogs.dart';
import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/screens/login/login.dart';
import 'package:shimmer/shimmer.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  DateTime _pressed = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: onWillPop,
        child: Consumer(
          builder: (context, watch, child) {
            var theme = watch(themeProvider);
            return Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  child: Opacity(
                    opacity: 0.3,
                    child: Image.asset(
                      "assets/images/shapes/main_top.png",
                      width: 350.w,
                      color: theme.isDarkMode ? Colors.white30 : null,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Image.asset(
                    "assets/images/shapes/main_bottom.png",
                    width: 350.w,
                    color: theme.isDarkMode ? Colors.white12 : null,
                  ),
                ),
                Positioned(
                  bottom: 350.h,
                  left: 20.w,
                  child: Container(
                    height: 300.w,
                    width: 300.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.indigo.withOpacity(0.1),
                          Colors.blueAccent.withOpacity(0.1),
                        ],
                      ),
                    ),
                  ),
                ),
                buildBody(),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<bool> onWillPop() async {
    DateTime current = DateTime.now();
    bool backButton = current.difference(_pressed) > Duration(seconds: 3);
    if (backButton) {
      _pressed = current;
      Kui().toast(context, "Double tap back to exit app");
      return false;
    } else {
      return UiDialog.choiseDialog(
        title: "Close App ?",
        lottie: MyAssets.ghost,
        color: context.read(themeProvider).isDarkMode
            ? XColors.darkColor2
            : XColors.darkColor2,
      );
    }
  }

  Container buildBody() {
    return Container(
      alignment: Alignment.center,
      child: Consumer(
        builder: (context, watch, child) {
          var theme = watch(themeProvider);
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 200.h,
                margin: EdgeInsets.only(
                  right: 50.w,
                  left: 50.w,
                  top: 50.h,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 150.w,
                      width: 150.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xff00c6ff).withOpacity(0.08),
                            Color(0xff0072ff).withOpacity(0.08),
                          ],
                        ),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(200.w),
                        onTap: () => theme.setMode(!theme.isDarkMode),
                        child: Shimmer.fromColors(
                          period: Duration(seconds: 5),
                          direction: ShimmerDirection.rtl,
                          highlightColor: theme.isDarkMode
                              ? Colors.amber
                              : XColors.darkColor,
                          baseColor: XColors.grayColor,
                          child: theme.isDarkMode
                              ? Icon(EvaIcons.sun)
                              : Icon(EvaIcons.moon),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Image.asset(
                "assets/images/png/library.png",
                filterQuality: FilterQuality.high,
                width: 900.w,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 50.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        KText(
                          "GeekLibrary",
                          font: "MavenPro",
                          size: 170.sp,
                          weight: FontWeight.bold,
                          color: theme.isDarkMode
                              ? XColors.darkGray
                              : XColors.darkColor.withOpacity(0.85),
                        ),
                      ],
                    ),
                    SizedBox(height: 50.h),
                    KText(
                      "Free and Open Libgen Search Engine",
                      size: 70.sp,
                      weight: FontWeight.w300,
                      color: theme.isDarkMode
                          ? XColors.darkGray
                          : XColors.darkColor.withOpacity(0.85),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 50.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    KClickable(
                      height: 200.h,
                      width: 800.w,
                      onPressed: () =>
                          Future.delayed(Duration(milliseconds: 150)).then(
                              (value) => Get.to(() => LoginScreen(),
                                  transition: Transition.fade)),
                      child: KText("Login",
                          weight: FontWeight.bold,
                          color: theme.isDarkMode
                              ? XColors.darkColor
                              : Colors.white),
                      topDeco: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            XColors.grayColor,
                            XColors.darkGray,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      bottomDeco: BoxDecoration(
                        color: theme.isDarkMode
                            ? XColors.darkColor2
                            : XColors.darkColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
