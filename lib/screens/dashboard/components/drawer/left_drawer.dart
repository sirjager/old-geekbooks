import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/packages/authentication/export/export.dart';
import 'package:geeklibrary/pages/sabed/sabed.dart';
import 'package:geeklibrary/screens/login/login.dart';
import 'package:geeklibrary/screens/welcome/welcome.dart';
import 'package:geeklibrary/widgets/kImage/kimage.dart';
import 'package:geeklibrary/widgets/kbuttons/kleaf_button.dart';

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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  color:
                      theme.isDarkMode ? XColors.darkColor : XColors.darkGray,
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
                Material(
                  color: Colors.transparent,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      buildMenuTile(
                        "Browse Library",
                        EvaIcons.searchOutline,
                        onTap: () {
                          Get.off(() => Dashboard());
                        },
                      ),
                      buildMenuTile(
                        "Cached Results",
                        Ionicons.library_outline,
                        onTap: () {
                          Get.to(() => SabedOffline());
                        },
                      ),
                      buildMenuTile(
                        "Share App",
                        EvaIcons.searchOutline,
                      ),
                      buildMenuTile(
                        "About",
                        EvaIcons.infoOutline,
                      ),
                      buildMenuTile(
                        "Privacy",
                        EvaIcons.shieldOutline,
                      ),
                      buildMenuTile("Settings", EvaIcons.settingsOutline,
                          onTap: () {
                        context.read(navigationProvider).changeTo(1);
                        Get.off(() => Dashboard());
                      }),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: R.h(info, 5),
                horizontal: R.w(info, 5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  KLeafButton(
                    radius: 0,
                    icon: EvaIcons.logOutOutline,
                    height: R.h(info, 6),
                    width: R.w(info, 40),
                    onPressed: () {
                      context.read(auth).signOut().then(
                            (_) => Future.delayed(Duration(seconds: 1))
                                .then((_) => Get.offAll(WelcomeScreen())),
                          );
                    },
                    child: KText(
                      "Logout",
                      font: "Poppins",
                      weight: FontWeight.bold,
                      color: theme.isDarkMode
                          ? Colors.white
                          : XColors.darkColor.withOpacity(0.7),
                    ),
                    color1: theme.isDarkMode
                        ? XColors.darkColor
                        : XColors.grayColor,
                    color2: theme.isDarkMode
                        ? XColors.grayColor
                        : XColors.lightColor1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuTile(String title, IconData icon, {VoidCallback? onTap}) {
    return Container(
      margin: EdgeInsets.only(left: 5),
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Material(
        child: InkWell(
          onTap: () {
            if (onTap != null) onTap();
            print("$title Pressed");
          },
          highlightColor: Colors.black38,
          splashColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: R.w(info, 5),
              vertical: R.w(info, 3),
            ),
            child: Row(
              children: [
                KText(
                  title,
                  font: "Poppins",
                  size: R.f(info, 14),
                  weight: FontWeight.w600,
                  color: XColors.darkColor.withOpacity(0.7),
                ),
                SizedBox(width: R.w(info, 3)),
                Icon(
                  icon,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
