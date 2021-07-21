import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/screens/dashboard/components/drawer/items.dart';
import 'package:geeklibrary/screens/dashboard/components/drawer/provider/dmi_provider.dart';
import 'package:geeklibrary/widgets/kswitches/kroll_switch.dart';

class LeftDrawer extends ConsumerWidget {
  LeftDrawer(this.info, {Key? key}) : super(key: key);
  final SizingInformation info;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var theme = watch(themeProvider);
    return Container(
      width: R.w(info, 65),
      height: double.infinity,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Container(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(top: R.statusbarHeight(info)),
                color: theme.isDarkMode
                    ? XColors.darkColor1
                    : Theme.of(context).scaffoldBackgroundColor,
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Container(
                      height: R.h(info, 5),
                      margin: EdgeInsets.only(
                        left: R.w(info, 5),
                        right: R.w(info, 5),
                        top: R.h(info, 1.2),
                      ),
                      child: Row(
                        children: [
                          Material(
                            color: Colors.transparent,
                            child: IconButton(
                              splashColor: Colors.transparent,
                              onPressed: () => Get.back(),
                              iconSize: R.w(info, 6),
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
                          size: R.f(info, 25),
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
                  children: KDMI.items
                      .map(
                        (i) => builTile(i),
                      )
                      .toList(),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.only(
                  bottom: R.w(info, 5),
                  left: R.w(info, 2),
                  right: R.w(info, 2),
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: R.w(info, 2)),
                      child: KText(
                        "Dark Mode",
                        font: "Nunito",
                        size: R.f(info, 18),
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
            ),
            trailing: Icon(
              item.icon,
              size: R.f(info, 20),
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
