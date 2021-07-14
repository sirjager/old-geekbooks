import 'package:geeklibrary/export/export.dart';

class KDrawer extends StatelessWidget {
  const KDrawer(this.info, {Key? key}) : super(key: key);
  final SizingInformation info;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: R.w(info, 60),
      height: double.infinity,
      color: Colors.green[100],
    );
  }
}
