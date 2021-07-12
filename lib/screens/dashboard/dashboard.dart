import 'package:geekbooks/export/export.dart';

import 'package:geekbooks/screens/dashboard/view/desktop.dart';
import 'package:geekbooks/screens/dashboard/view/tablet.dart';

class Dashboard extends ConsumerWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var scaf = watch(drawerProvider);
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
