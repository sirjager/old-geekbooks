import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/global/titlebar/titlebar.dart';

class Settingspage extends StatelessWidget {
  final SizingInformation info;
  const Settingspage(this.info, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(
        horizontal: R.w(info, 1),
        vertical: R.statusbarHeight(info),
      ),
      child: Column(
        children: [
          Titlebar(info),
          AppTitle(info, title: "Settings"),
        ],
      ),
    );
  }
}
