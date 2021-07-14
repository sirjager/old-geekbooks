import 'package:geeklibrary/export/export.dart';

class AppTitle extends StatelessWidget {
  final SizingInformation info;
  const AppTitle(this.info, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: R.w(info, 7), vertical: R.h(info, 2)),
      alignment: Alignment.center,
      child: Row(
        children: [
          KText(
            "Browse library",
            font: "MavenPro",
            letterSpacing: 1,
            size: R.f(info, 20),
            weight: FontWeight.w500,
            color: Color(0xff555555),
          ),
        ],
      ),
    );
  }
}
