import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/pages/sabed/sabed.dart';
import 'package:geeklibrary/screens/dashboard/components/drawer/items.dart';
import 'package:geeklibrary/screens/dashboard/components/drawer/provider/dmi_provider.dart';
import 'package:geeklibrary/widgets/kswitches/kroll_switch.dart';

class LeftDrawer extends ConsumerWidget {
  LeftDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var theme = watch(themeProvider);
    return Container(
      width: 700.w,
      height: double.infinity,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Container(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(top: ScreenUtil().statusBarHeight),
                color: theme.isDarkMode
                    ? XColors.darkColor1
                    : Theme.of(context).scaffoldBackgroundColor,
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Container(
                      height: 150.h,
                      margin:
                          EdgeInsets.only(left: 50.w, right: 50.w, top: 10.h),
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
            Expanded(
              flex: 8,
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
                              Get.offAll(() => Dashboard());
                            },
                            title: KText(
                              "Searchs",
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
                              Get.to(() => SabedOffline());
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
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: KText(
                        "Dark Mode",
                        font: "Nunito",
                        size: 60.sp,
                        weight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => theme.setMode(!theme.isDarkMode),
                      child: KRollSwitch(
                        height: 100.h,
                        width: 200.w,
                        isOn: theme.isDarkMode,
                        iconOn: EvaIcons.moon,
                        iconOff: EvaIcons.sun,
                        colorOff: XColors.grayColor,
                        colorOn: XColors.darkColor2,
                        iconOffColor: XColors.darkColor,
                        textOnColor: Colors.white,
                        textOffColor: XColors.darkColor,
                      ),
                    ),
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
