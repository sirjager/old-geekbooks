import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geeklibrary/backend/dialog/dialog.dart';
import 'package:geeklibrary/core/dialog/dialogs.dart';
import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/packages/authentication/export/export.dart';
import 'package:geeklibrary/packages/authentication/functions/firestore_operations.dart';
import 'package:geeklibrary/screens/dashboard/components/drawer/left_drawer.dart';
import 'package:geeklibrary/screens/dashboard/components/navigation/navbar.dart';

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
        var nav = watch(navigationProvider);
        return Scaffold(
          key: drawer.scaffoldKey,
          drawer: LeftDrawer(),
          resizeToAvoidBottomInset: false,
          body: WillPopScope(
            onWillPop: onWillPop,
            child: Column(
              children: [
                Expanded(
                  child: PageView(
                    // physics: C,
                    controller: nav.pageController,
                    physics: ClampingScrollPhysics(),
                    onPageChanged: (int index) => nav.changeTo(index),
                    children: [Homepage(), Settingspage()],
                  ),
                ),
                Navigationbar(),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<bool> onWillPop() async {
    final String _uid = FirebaseAuth.instance.currentUser!.uid;
    var _acc = context.read(accountProvider).account;
    var isDarkMode = context.read(themeProvider).isDarkMode;
    DateTime current = DateTime.now();
    bool backButton = current.difference(_pressed) > Duration(seconds: 3);
    if (backButton) {
      _pressed = current;
      Kui().toast(context, "Double tap back to exit app");
      return false;
    } else {
      var result = await UiDialog.choiseDialog(
        title: "Exit App ?",
        lottie: MyAssets.ghost,
        color: context.read(themeProvider).isDarkMode
            ? XColors.darkColor2
            : XColors.darkColor2,
      );
      if (result == true) {
        await FirestoreOperations.saveAccountDetails(
            _uid, _acc.copyWith(isDarkThemeEnabled: isDarkMode));
        return true;
      } else
        return false;
    }
  }
}
