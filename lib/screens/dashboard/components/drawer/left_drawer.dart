import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/widgets/kImage/kimage.dart';
import 'package:geeklibrary/widgets/kswitches/kroll_switch.dart';

class LeftDrawer extends ConsumerWidget {
  LeftDrawer(this.info, {Key? key}) : super(key: key);
  final SizingInformation info;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final String img =
        "https://cdn2.vectorstock.com/i/1000x1000/20/76/man-avatar-profile-vector-21372076.jpg";

    var theme = watch(themeProvider);
    return Container(
      height: double.infinity,
      width: R.w(info, 65),
      padding: EdgeInsets.symmetric(),
      color: XColors.darkColor,
      child: Container(
        color: theme.isDarkMode ? XColors.darkColor : Colors.white,
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              color: theme.isDarkMode ? XColors.darkColor : XColors.darkGray,
              child: Container(
                margin: EdgeInsets.only(
                  top: R.h(info, 5),
                  bottom: R.h(info, 2),
                  left: R.w(info, 4),
                  right: R.w(info, 4),
                ),
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: R.w(info, 25),
                      height: R.w(info, 25),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: KImage(
                        imageURL: img,
                        fit: BoxFit.cover,
                        height: double.infinity,
                        width: double.infinity,
                      ),
                    ),
                    SizedBox(height: R.h(info, 2)),
                    KText(
                      "Mr. Masatao",
                      size: R.f(info, 17),
                      font: "MavenPro",
                      weight: FontWeight.bold,
                    ),
                    SizedBox(height: R.h(info, 2)),
                    KText(
                      "mrmasato@gmail.com",
                      size: R.f(info, 10),
                      font: "MavenPro",
                      weight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: R.h(info, 1)),
                  child: GestureDetector(
                    onTap: () async {
                      theme.setMode(!theme.isDarkMode);
                      // Future.delayed(Duration(seconds: 3)).then((_) {
                      //   BackEndOperation.updateUser(
                      //       'isDarkThemeEnabled', theme.isDarkMode);
                      // });
                    },
                    child: KRollSwitch(
                      isOn: theme.isDarkMode,
                      iconOn: EvaIcons.moon,
                      iconOff: EvaIcons.sun,
                      colorOff: Colors.white,
                      colorOn: XColors.darkColor,
                      iconOffColor: XColors.darkColor,
                      textOnColor: Colors.white,
                      textOffColor: XColors.darkColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
