import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/packages/authentication/export/export.dart';
import 'package:geeklibrary/pages/profile/profile.dart';
import 'package:geeklibrary/screens/welcome/welcome.dart';
import 'package:geeklibrary/widgets/kbuttons/kleaf_button.dart';

class LeftDrawer extends ConsumerWidget {
  LeftDrawer(this.info, {Key? key}) : super(key: key);
  final SizingInformation info;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var theme = watch(themeProvider);
    var avatar = watch(avatarProvider);
    var _acc = watch(accountProvider).account;

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
                          margin: EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.greenAccent,
                          ),
                          child: Container(
                            margin: EdgeInsets.all(R.w(info, 1)),
                            padding: EdgeInsets.only(
                              top: R.w(info, 2),
                              left: R.w(info, 1),
                              right: R.w(info, 1),
                            ),
                            alignment: Alignment.bottomCenter,
                            child: SvgPicture.asset(
                              _avatarImage(avatar.avatar),
                              fit: BoxFit.contain,
                            ),
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              gradient:
                                  XGradient.gradient[avatar.avatarGradient],
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        SizedBox(height: R.h(info, 2)),
                        KText(
                          _acc.name.toString(),
                          size: R.f(info, 17),
                          font: "MavenPro",
                          weight: FontWeight.bold,
                        ),
                        SizedBox(height: R.h(info, 2)),
                        KText(
                          _acc.email.toString(),
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
                        "Profile",
                        Typicons.user_outline,
                        onTap: () => Get.to(() => ProfilePage()),
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
                horizontal: R.w(info, 2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  KLeafButton(
                    radius: 0,
                    icon: EvaIcons.logOutOutline,
                    height: R.h(info, 6),
                    width: R.w(info, 35),
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
                  KClickable(
                    height: R.w(info, 9),
                    width: R.w(info, 9),
                    onPressed: () => Get.offAll(VerificationCheck()),
                    child: Center(
                        child: Icon(
                      EvaIcons.refresh,
                      size: R.f(info, 12),
                    )),
                    topDeco: BoxDecoration(
                      color: theme.isDarkMode
                          ? XColors.darkColor1
                          : XColors.grayColor,
                      shape: BoxShape.circle,
                    ),
                    bottomDeco: BoxDecoration(
                      color: theme.isDarkMode
                          ? XColors.grayColor.withOpacity(0.5)
                          : XColors.darkColor2,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _avatarImage(int index) =>
      "assets/images/avatar/p" + index.toString() + ".svg";

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
