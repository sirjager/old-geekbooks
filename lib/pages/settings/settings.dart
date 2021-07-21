import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/global/titlebar/titlebar.dart';

class Settingspage extends StatelessWidget {
  final SizingInformation info;
  const Settingspage(this.info, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        buildShapes(),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(
            horizontal: R.w(info, 1),
            vertical: R.statusbarHeight(info),
          ),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Titlebar(info),
                AppTitle(info, title: "Settings"),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: R.w(info, 5), vertical: R.h(info, 1)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildTile("Offline", EvaIcons.downloadOutline),
                      buildTile("Feedback", LineIcons.sms),
                      buildTile("App Info", EvaIcons.infoOutline),
                      buildTile("Contact Us", EvaIcons.peopleOutline),
                      buildTile("Report Bug", Ionicons.bug_outline),
                      buildTile(
                          "Help Center", EvaIcons.questionMarkCircleOutline),
                      buildTile("Share App", EvaIcons.shareOutline),
                      buildTile("Privacy Policy", EvaIcons.fileOutline),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Consumer(
                        builder: (context, watch, child) {
                          bool isDarkMode = watch(themeProvider).isDarkMode;
                          return KText(
                            "App version : v1.0",
                            size: R.f(info, 11),
                            color: isDarkMode
                                ? XColors.grayColor.withOpacity(0.7)
                                : XColors.darkColor.withOpacity(0.5),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
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
                  width: R.w(info, 45),
                  color: isDarkMode
                      ? Colors.white.withOpacity(0.07)
                      : Colors.red.withOpacity(0.1),
                ),
              ),
              AnimatedPositioned(
                bottom: isDarkMode ? 0 : R.h(info, 65),
                left: isDarkMode ? 0 : R.w(info, 75),
                curve: Curves.fastOutSlowIn,
                duration: Duration(seconds: 3),
                child: AnimatedContainer(
                  curve: Curves.fastOutSlowIn,
                  duration: Duration(seconds: 2),
                  height: isDarkMode ? R.w(info, 25) : R.w(info, 30),
                  width: isDarkMode ? R.w(info, 25) : R.w(info, 30),
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

  Widget buildTile(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(10),
        splashColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(R.w(info, 2)),
          width: R.w(info, 75),
          child: Consumer(
            builder: (context, watch, child) {
              var isDarkMode = watch(themeProvider).isDarkMode;
              return Row(
                children: [
                  Icon(
                    icon,
                    size: R.f(info, 20),
                    color: isDarkMode ? XColors.grayColor : Color(0xff555555),
                  ),
                  SizedBox(width: R.w(info, 7)),
                  KText(
                    title,
                    font: "Nunito",
                    size: R.f(info, 15),
                    weight: FontWeight.w400,
                    color: isDarkMode ? XColors.grayColor : Color(0xff555555),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
