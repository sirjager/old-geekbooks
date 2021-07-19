import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/screens/login/login.dart';
import 'package:geeklibrary/screens/signup/signup.dart';
import 'package:shimmer/shimmer.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var _theme = watch(themeProvider);
    return ResponsiveBuilder(
      builder: (context, info) {
        return Scaffold(
          body: Container(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  child: Image.asset(
                    "assets/images/shapes/main_top.png",
                    width: R.w(info, 40),
                    filterQuality: FilterQuality.high,
                    color: _theme.isDarkMode ? Colors.white12 : null,
                  ),
                ),
                Positioned(
                  top: R.h(info, 5),
                  right: R.w(info, 5),
                  child: Container(
                    height: R.w(info, 10),
                    width: R.w(info, 10),
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
                      borderRadius: BorderRadius.circular(R.w(info, 50)),
                      onTap: () => _theme.setMode(!_theme.isDarkMode),
                      child: Shimmer.fromColors(
                        period: Duration(seconds: 5),
                        direction: ShimmerDirection.rtl,
                        highlightColor: _theme.isDarkMode
                            ? Colors.amber
                            : XColors.darkColor,
                        baseColor: XColors.grayColor,
                        child: _theme.isDarkMode
                            ? Icon(EvaIcons.sun)
                            : Icon(EvaIcons.moon),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: R.h(info, 40),
                  right: R.w(info, 20),
                  child: Container(
                    height: R.w(info, 20),
                    width: R.w(info, 20),
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
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Image.asset(
                    "assets/images/shapes/main_bottom.png",
                    width: R.w(info, 30),
                    color: _theme.isDarkMode ? Colors.white12 : null,
                  ),
                ),
                WelcomeBody(info),
              ],
            ),
          ),
        );
      },
    );
  }
}

class WelcomeBody extends ConsumerWidget {
  const WelcomeBody(this.info, {Key? key}) : super(key: key);
  final SizingInformation info;
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var isDark = watch(themeProvider).isDarkMode;
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/png/library.png",
                    filterQuality: FilterQuality.high,
                    width: R.w(info, 90),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: R.w(info, 5)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            KText(
                              "GeekLibrary",
                              font: "MavenPro",
                              size: R.f(info, 35),
                              weight: FontWeight.bold,
                              color: isDark
                                  ? XColors.darkGray
                                  : XColors.darkColor.withOpacity(0.85),
                            ),
                          ],
                        ),
                        SizedBox(height: R.h(info, 1)),
                        KText(
                          "Free and Open Libgen Search Engine",
                          size: R.f(info, 15),
                          weight: FontWeight.w300,
                          height: R.h(info, 0.135),
                          color: isDark
                              ? XColors.darkGray
                              : XColors.darkColor.withOpacity(0.85),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.only(top: R.h(info, 5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      KClickable(
                        width: R.w(info, 80),
                        onPressed: () => Get.to(
                          () => LoginScreen(),
                          transition: Transition.rightToLeftWithFade,
                        ),
                        child: Shimmer.fromColors(
                          period: Duration(seconds: 5),
                          highlightColor:
                              isDark ? Colors.black12 : Colors.white12,
                          baseColor: isDark ? XColors.darkColor : Colors.white,
                          child: KText(
                            "Login",
                            weight: FontWeight.bold,
                            color: isDark ? XColors.darkColor : Colors.white,
                          ),
                        ),
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
                          color:
                              isDark ? XColors.darkColor2 : XColors.darkColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: R.h(info, 2),
                    bottom: R.h(info, 5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      KClickable(
                        width: R.w(info, 80),
                        onPressed: () => Get.to(
                          () => SignUpScreen(),
                          transition: Transition.rightToLeftWithFade,
                        ),
                        child: Shimmer.fromColors(
                          period: Duration(seconds: 5),
                          highlightColor:
                              isDark ? Colors.blueGrey : Colors.blueGrey,
                          baseColor:
                              isDark ? XColors.grayColor : XColors.grayColor,
                          child: KText(
                            "Sign up",
                            weight: FontWeight.bold,
                            color: XColors.grayColor,
                          ),
                        ),
                        topDeco: BoxDecoration(
                          color: isDark ? XColors.darkColor : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        bottomDeco: BoxDecoration(
                          border: Border.all(
                            color: XColors.grayColor,
                            width: R.w(info, 1),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
