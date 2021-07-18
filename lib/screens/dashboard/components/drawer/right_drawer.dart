import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/widgets/kswitches/kroll_switch.dart';

class RightDrawer extends StatelessWidget {
  const RightDrawer(this.info, {Key? key}) : super(key: key);
  final SizingInformation info;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      decoration: BoxDecoration(
        color: Get.isDarkMode ? XColors.darkColor2 : XColors.grayText,
        borderRadius: BorderRadius.horizontal(left: Radius.circular(24)),
      ),
      child: Consumer(
        builder: (context, watch, child) {
          var theme = watch(themeProvider);
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: R.h(info, 2)),
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
          );
        },
      ),
    );
  }
}
