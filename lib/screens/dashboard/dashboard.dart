import 'package:geeklibrary/backend/dialog/dialog.dart';
import 'package:geeklibrary/core/dialog/dialogs.dart';
import 'package:geeklibrary/export/export.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  DateTime _pressed = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        watch(themeProvider);
        var drawer = watch(drawerProvider);
        return Scaffold(
          key: drawer.scaffoldKey,
          resizeToAvoidBottomInset: false,
          body: WillPopScope(
            onWillPop: onWillPop,
            child: Homepage(),
          ),
        );
      },
    );
  }

  Future<bool> onWillPop() async {
    DateTime current = DateTime.now();
    bool backButton = current.difference(_pressed) > Duration(seconds: 3);
    if (backButton) {
      _pressed = current;
      Kui().toast("Double tap back to exit app");
      return false;
    } else {
      var result = await UiDialog.choiseDialog(
        title: "Exit App ?",
        lottie: MyAssets.ghost,
        color: context.read(themeProvider).isDarkMode
            ? XColors.darkColor2
            : XColors.darkColor2,
      );
      return result;
    }
  }
}
