import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/packages/authentication/export/export.dart';
import 'package:geeklibrary/pages/sabed/sabed.dart';
import 'package:geeklibrary/screens/dashboard/components/drawer/items.dart';
import 'package:geeklibrary/screens/dashboard/components/drawer/provider/dmi_provider.dart';
import 'package:geeklibrary/screens/welcome/welcome.dart';
import 'package:geeklibrary/widgets/kbuttons/kleaf_button.dart';

class LeftDrawer extends ConsumerWidget {
  LeftDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var theme = watch(themeProvider);
    return Container(
      width: 800.w,
      height: double.infinity,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Container(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(),
                color: theme.isDarkMode
                    ? XColors.darkColor1
                    : XColors.grayColor.withOpacity(0.5),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Container(
                              height: 150.h,
                              margin: EdgeInsets.only(
                                left: 50.w,
                                right: 50.w,
                                top: ScreenUtil().statusBarHeight,
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () => Get.back(),
                                    iconSize: 70.w,
                                    icon: Icon(
                                      EvaIcons.closeCircleOutline,
                                      size: 110.sp,
                                    ),
                                    color: theme.isDarkMode
                                        ? XColors.grayText
                                        : XColors.darkColor1,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                child: KText(
                                  "GeekLibrary",
                                  font: "MavenPro",
                                  size: 100.sp,
                                  weight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                child: Column(
                  children: [
                    Consumer(
                      builder: (context, watch, child) {
                        bool isDark = watch(themeProvider).isDarkMode;

                        return Material(
                          color: Colors.transparent,
                          child: ListTile(
                            onTap: () {
                              Get.back();
                              Future.delayed(Duration(milliseconds: 200)).then(
                                  (value) => Get.offAll(() => Dashboard()));
                            },
                            title: KText(
                              "Search",
                              font: "Nunito",
                              weight: FontWeight.w600,
                              color: isDark
                                  ? XColors.grayColor
                                  : XColors.grayColor,
                              size: 65.sp,
                            ),
                            trailing: Icon(
                              EvaIcons.searchOutline,
                              size: 80.sp,
                              color: isDark
                                  ? XColors.grayColor
                                  : XColors.grayColor,
                            ),
                          ),
                        );
                      },
                    ),
                    Consumer(
                      builder: (context, watch, child) {
                        bool isDark = watch(themeProvider).isDarkMode;
                        return Material(
                          color: Colors.transparent,
                          child: ListTile(
                            onTap: () {
                              Get.back();
                              Future.delayed(Duration(milliseconds: 200)).then(
                                  (value) => Get.offAll(() => SabedOffline()));
                            },
                            title: KText(
                              "Offline",
                              font: "Nunito",
                              weight: FontWeight.w600,
                              color: isDark
                                  ? XColors.grayColor
                                  : XColors.grayColor,
                              size: 65.sp,
                            ),
                            trailing: Icon(
                              EvaIcons.downloadOutline,
                              size: 80.sp,
                              color: isDark
                                  ? XColors.grayColor
                                  : XColors.grayColor,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.only(
                  bottom: 50.h,
                  left: 30.w,
                  right: 30.w,
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    KLeafButton(
                      onPressed: () async => theme.setMode(!theme.isDarkMode),
                      height: 120.h,
                      radius: 0,
                      isPressed: theme.isDarkMode,
                      child: Text("Dark"),
                      icon: theme.isDarkMode ? EvaIcons.moon : EvaIcons.sun,
                      iconColor: theme.isDarkMode
                          ? XColors.lightColor1
                          : XColors.darkGray,
                      color1: theme.isDarkMode
                          ? XColors.darkColor1
                          : XColors.darkGray,
                      color2: theme.isDarkMode
                          ? XColors.darkColor3
                          : XColors.lightColor1,
                    ),
                    KLeafButton(
                      onPressed: () => context
                          .read(auth)
                          .signOut()
                          .then((value) => Future.delayed(Duration(seconds: 1)))
                          .then((value) => Get.offAll(() => WelcomeScreen())),
                      height: 120.h,
                      radius: 0,
                      child: Text("Logout"),
                      icon: EvaIcons.logOutOutline,
                      iconColor: theme.isDarkMode
                          ? XColors.lightColor1
                          : XColors.darkGray,
                      color1: theme.isDarkMode
                          ? XColors.darkColor1
                          : XColors.darkGray,
                      color2: theme.isDarkMode
                          ? XColors.darkColor3
                          : XColors.lightColor1,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget builTile(Dmi item) {
    return Consumer(
      builder: (context, watch, child) {
        var s = watch(drawerItems);
        bool isDark = watch(themeProvider).isDarkMode;
        bool selected = s.selected == item.index;
        return Material(
          color: Colors.transparent,
          child: ListTile(
            onTap: () => s.select(item.index),
            selected: selected,
            selectedTileColor: selected ? XColors.grayColor : Colors.black,
            title: KText(
              item.title,
              font: "Nunito",
              weight: FontWeight.w600,
              color: isDark
                  ? selected
                      ? XColors.darkColor
                      : XColors.grayColor
                  : selected
                      ? XColors.darkColor
                      : XColors.grayColor,
              size: 65.sp,
            ),
            trailing: Icon(
              item.icon,
              size: 80.sp,
              color: isDark
                  ? selected
                      ? XColors.darkColor
                      : XColors.grayColor
                  : selected
                      ? XColors.darkColor
                      : XColors.grayColor,
            ),
          ),
        );
      },
    );
  }
}
