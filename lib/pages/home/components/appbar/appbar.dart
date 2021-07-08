import 'package:geekbooks/export/export.dart';

class Topbar extends StatelessWidget {
  const Topbar(this.info, {Key? key}) : super(key: key);

  final SizingInformation info;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: R.w(info, 5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: R.w(info, 10),
            width: R.w(info, 10),
            alignment: Alignment.center,
            child: RotatedBox(
              quarterTurns: 1,
              child: Consumer(
                builder: (context, watch, child) {
                  var scaf = watch(drawerProvider);
                  return IconButton(
                    onPressed: () =>
                        scaf.scaffoldKey.currentState!.openDrawer(),
                    iconSize: R.w(info, 6),
                    icon: Icon(EvaIcons.barChartOutline),
                  );
                },
              ),
            ),
          ),
          Container(
            height: R.w(info, 10),
            width: R.w(info, 10),
            alignment: Alignment.center,
            child: Stack(
              children: [
                IconButton(
                  onPressed: () {},
                  iconSize: R.w(info, 6),
                  icon: Icon(EvaIcons.bellOutline),
                  color: XColors.grayColor,
                ),
                Positioned(
                  top: 0,
                  right: R.w(info, 2),
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: R.h(info, 0.5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
