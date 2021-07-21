import 'package:geeklibrary/export/export.dart';

class LeftDrawer extends ConsumerWidget {
  LeftDrawer(this.info, {Key? key}) : super(key: key);
  final SizingInformation info;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var theme = watch(themeProvider);
    return Container(
      height: double.infinity,
      width: R.w(info, 65),
      padding: EdgeInsets.symmetric(),
      color: XColors.darkColor,
      child: Container(
        color: Colors.red,
      ),
    );
  }

  Widget buildMenuTile(String title, IconData icon, {VoidCallback? onTap}) {
    return Container(
      margin: EdgeInsets.only(left: 5),
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Material(
        child: InkWell(
          onTap: () {
            if (onTap != null) onTap();
            print("$title Pressed");
          },
          highlightColor: Colors.black38,
          splashColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: R.w(info, 5),
              vertical: R.w(info, 3),
            ),
            child: Row(
              children: [
                KText(
                  title,
                  font: "Poppins",
                  size: R.f(info, 14),
                  weight: FontWeight.w600,
                  color: XColors.darkColor.withOpacity(0.7),
                ),
                SizedBox(width: R.w(info, 3)),
                Icon(
                  icon,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
