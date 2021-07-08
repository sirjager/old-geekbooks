import 'package:geekbooks/export/export.dart';
import 'package:geekbooks/screens/dashboard/components/navigation/view/mobile.dart';
import 'package:geekbooks/screens/dashboard/components/navigation/view/tablet.dart';

class NavigationLayout extends StatelessWidget {
  const NavigationLayout(this.info, {Key? key}) : super(key: key);
  final SizingInformation info;
  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
      mobile: NavigationMobile(info),
      tablet: NavigationTablet(info),
    );
  }
}
