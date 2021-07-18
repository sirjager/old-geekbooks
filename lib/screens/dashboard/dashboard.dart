import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/screens/dashboard/components/drawer/left_drawer.dart';
import 'package:geeklibrary/screens/dashboard/view/desktop.dart';
import 'package:geeklibrary/screens/dashboard/view/tablet.dart';

class Dashboard extends ConsumerWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    watch(themeProvider);
    var drawer = watch(drawerProvider);
    return ResponsiveBuilder(
      builder: (context, info) {
        return Scaffold(
          key: drawer.scaffoldKey,
          drawer: LeftDrawer(info),
          endDrawer: RightDrawer(info),
          body: ScreenLayout(
            mobile: DashboardMobile(info),
            tablet: DashboardTablet(info),
            desktop: DashboardDesktop(info),
          ),
        );
      },
    );
  }
}
