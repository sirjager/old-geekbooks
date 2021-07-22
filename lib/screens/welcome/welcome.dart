import 'package:geeklibrary/export/export.dart';
import 'package:shimmer/shimmer.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, info) {
        return Scaffold(
          body: Consumer(
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
                        width: R.w(info, 50),
                        color: theme.isDarkMode ? Colors.white30 : null,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Image.asset(
                      "assets/images/shapes/main_bottom.png",
                      width: R.w(info, 30),
                      color: theme.isDarkMode ? Colors.white12 : null,
                    ),
                  ),
                  Positioned(
                    bottom: R.h(info, 28),
                    left: R.w(info, 1),
                    child: Container(
                      height: R.w(info, 40),
                      width: R.w(info, 40),
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
                  buildBody(info),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Container buildBody(SizingInformation info) {
    return Container(
      alignment: Alignment.center,
      child: Consumer(
        builder: (context, watch, child) {
          var theme = watch(themeProvider);
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: R.h(info, 5),
                margin: EdgeInsets.only(
                  right: R.w(info, 4),
                  left: R.w(info, 4),
                  top: R.appbarHeight,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
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
              Expanded(
                child: Image.asset(
                  "assets/images/png/library.png",
                  filterQuality: FilterQuality.high,
                ),
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
                          size: R.w(info, 10),
                          weight: FontWeight.bold,
                          color: theme.isDarkMode
                              ? XColors.darkGray
                              : XColors.darkColor.withOpacity(0.85),
                        ),
                      ],
                    ),
                    SizedBox(height: R.h(info, 1)),
                    KText(
                      "Free and Open Libgen Search Engine",
                      size: R.w(info, 5),
                      weight: FontWeight.w300,
                      height: R.h(info, 0.135),
                      color: theme.isDarkMode
                          ? XColors.darkGray
                          : XColors.darkColor.withOpacity(0.85),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: R.h(info, 2),
                  left: R.w(info, 5),
                  right: R.w(info, 5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    KClickable(
                      width: R.w(info, 65),
                      onPressed: () =>
                          Future.delayed(Duration(milliseconds: 150)).then(
                              (value) => Get.offAll(() => Dashboard(),
                                  transition: Transition.fade)),
                      child: KText(
                        "Tutorial",
                        weight: FontWeight.bold,
                        color:
                            theme.isDarkMode ? XColors.darkColor : Colors.white,
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
                        color: theme.isDarkMode
                            ? XColors.darkColor2
                            : XColors.darkColor,
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
                  left: R.w(info, 5),
                  right: R.w(info, 5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    KClickable(
                      width: R.w(info, 65),
                      onPressed: () =>
                          Future.delayed(Duration(milliseconds: 150)).then(
                              (value) => Get.offAll(() => Dashboard(),
                                  transition: Transition.fade)),
                      child: KText(
                        "Home",
                        weight: FontWeight.bold,
                        color: XColors.grayColor,
                      ),
                      topDeco: BoxDecoration(
                        color:
                            theme.isDarkMode ? XColors.darkColor : Colors.white,
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
          );
        },
      ),
    );
  }
}
