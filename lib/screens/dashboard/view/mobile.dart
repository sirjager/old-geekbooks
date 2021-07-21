import 'package:geeklibrary/export/export.dart';

class DashboardMobile extends ConsumerWidget {
  const DashboardMobile(this.info, {Key? key}) : super(key: key);
  final SizingInformation info;
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var nav = watch(navigationProvider);
    return Container(
      child: Column(
        children: [
          Expanded(
            child: PageView(
              // physics: C,
              controller: nav.pageController,
              physics: ClampingScrollPhysics(),
              onPageChanged: (int index) => nav.changeTo(index),
              children: [
                Homepage(info),
                Settingspage(info),
              ],
            ),
          ),
          NavigationLayout(info),
        ],
      ),
    );
  }
}
