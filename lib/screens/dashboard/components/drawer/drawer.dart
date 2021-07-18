import 'package:geeklibrary/backend/database/firestore.dart';
import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/widgets/kswitches/kroll_switch.dart';
import 'package:hive/hive.dart';

class KDrawer extends StatelessWidget {
  const KDrawer(this.info, {Key? key, this.isEndDrawer = false})
      : super(key: key);
  final SizingInformation info;
  final bool isEndDrawer;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      decoration: BoxDecoration(
        color: Get.isDarkMode ? XColors.darkColor2 : XColors.grayText,
        borderRadius: BorderRadius.horizontal(
          right: isEndDrawer ? Radius.circular(0) : Radius.circular(24),
          left: isEndDrawer ? Radius.circular(24) : Radius.circular(0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: R.h(info, 2)),
            child: Consumer(
              builder: (context, watch, child) {
                var theme = watch(themeProvider);
                return GestureDetector(
                  onTap: () async {
                    theme.setMode(!theme.isDarkMode);
                    Future.delayed(Duration(seconds: 5)).then((_) {
                      BackEndOperation.updateUser(
                          'isDarkThemeEnabled', theme.isDarkMode);
                    });
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
                );
              },
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: R.h(info, 2)),
            child: Consumer(
              builder: (context, watch, child) {
                var fav = watch(favProvider);
                return KClickable(
                  onPressed: () {
                    fav.setFav(!fav.isFav);
                    print(fav.isFav);
                  },
                  child: fav.isFav
                      ? Icon(EvaIcons.heart)
                      : Icon(EvaIcons.heartOutline),
                  topDeco: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: G.green3GradBannerDeco.gradient),
                  bottomDeco: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: G.blackGradButtonDeco.gradient),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
