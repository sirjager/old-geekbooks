import 'package:geeklibrary/export/export.dart';

import 'package:geeklibrary/screens/dashboard/view/desktop.dart';
import 'package:geeklibrary/screens/dashboard/view/tablet.dart';

class Dashboard extends ConsumerWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var scaf = watch(drawerProvider);
    watch(themeProvider).isDarkMode;
    return ResponsiveBuilder(
      builder: (context, info) {
        return Scaffold(
          key: scaf.scaffoldKey,
          drawer: KDrawer(info),
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
