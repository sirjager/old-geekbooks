import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/screens/dashboard/components/drawer/left_drawer.dart';
import 'package:geeklibrary/screens/dashboard/components/navigation/navbar.dart';

class Dashboard extends ConsumerWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    watch(themeProvider);
    var drawer = watch(drawerProvider);
    var nav = watch(navigationProvider);
    return Scaffold(
      key: drawer.scaffoldKey,
      drawer: LeftDrawer(),
      resizeToAvoidBottomInset: false,
      body: Column(
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
    );
  }
}
