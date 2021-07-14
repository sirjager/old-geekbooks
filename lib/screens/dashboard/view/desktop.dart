import 'package:geeklibrary/export/export.dart';

class DashboardDesktop extends ConsumerWidget {
  const DashboardDesktop(this.info, {Key? key}) : super(key: key);
  final SizingInformation info;
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var nav = watch(navigationProvider);
    return Container(
      child: Column(
        children: [
          Expanded(
              child: nav.current == 0 ? Homepage(info) : Settingspage(info)),
          NavigationLayout(info),
        ],
      ),
    );
  }
}
