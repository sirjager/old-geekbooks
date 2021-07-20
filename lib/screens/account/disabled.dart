import 'package:geeklibrary/export/export.dart';
import 'package:shimmer/shimmer.dart';

class AccountStatus extends StatelessWidget {
  const AccountStatus({Key? key, this.status = "", this.msg = ""})
      : super(key: key);
  final String status;
  final String msg;
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, info) {
        return Scaffold(
          body: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                child: Opacity(
                  opacity: 0.5,
                  child: Image.asset(
                    "assets/images/shapes/main_top.png",
                    width: R.w(info, 35),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: RotatedBox(
                  quarterTurns: 2,
                  child: Opacity(
                    opacity: 0.5,
                    child: Image.asset(
                      "assets/images/shapes/signup_top.png",
                      width: R.w(info, 35),
                    ),
                  ),
                ),
              ),
              buildBody(info),
            ],
          ),
        );
      },
    );
  }

  Container buildBody(SizingInformation info) {
    return Container(
      margin: EdgeInsets.only(top: R.appbarHeight),
      alignment: Alignment.center,
      child: Consumer(
        builder: (context, watch, child) {
          var theme = watch(themeProvider);
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                // Theme Changer
                height: R.h(info, 5),
                margin: EdgeInsets.symmetric(horizontal: R.w(info, 4)),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/png/lazy.png",
                        filterQuality: FilterQuality.high,
                        width: R.w(info, 90)),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: R.w(info, 5)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: R.w(info, 90),
                                child: KText(
                                  "Inactive Account",
                                  font: "MavenPro",
                                  size: R.f(info, 30),
                                  weight: FontWeight.bold,
                                  color: Colors.redAccent.withOpacity(0.85),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: R.h(info, 1)),
                          SizedBox(
                            width: R.w(info, 90),
                            child: KText(
                              msg,
                              size: R.f(info, 15),
                              weight: FontWeight.w300,
                              height: R.h(info, 0.135),
                              color: theme.isDarkMode
                                  ? XColors.darkGray
                                  : XColors.darkColor.withOpacity(0.85),
                            ),
                          ),
                        ],
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
