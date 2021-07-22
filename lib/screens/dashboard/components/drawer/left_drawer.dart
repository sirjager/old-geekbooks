import 'package:geeklibrary/export/export.dart';
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
                          EdgeInsets.only(left: 50.w, right: 50.w, top: 30.h),
                      child: Row(
                        children: [
                          Material(
                            color: Colors.transparent,
                            child: IconButton(
                              splashColor: Colors.transparent,
                              onPressed: () => Get.back(),
                              iconSize: 100.sp,
                              icon: Icon(Ionicons.logo_xbox),
                              color: theme.isDarkMode
                                  ? XColors.grayText
                                  : XColors.darkColor1,
                            ),
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
                  children: KDMI.items.map((i) => builTile(i)).toList(),
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
                        size: 80.sp,
                        weight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => theme.setMode(!theme.isDarkMode),
                      child: KRollSwitch(
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
