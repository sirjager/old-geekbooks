import 'package:geekbooks/export/export.dart';

class DashboardTablet extends ConsumerWidget {
  const DashboardTablet(this.info, {Key? key}) : super(key: key);
  final SizingInformation info;
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var nav = watch(navigationProvider);
    return Container(
      child: Column(
        children: [
          Expanded(child: nav.current == 0 ? Homepage(info) : Settingspage()),
          NavigationLayout(info),
        ],
      ),
    );
  }
}
