import 'package:geekbooks/export/export.dart';

class Titlebar extends StatelessWidget {
  const Titlebar(
    this.info, {
    Key? key,
    this.title = "",
    this.leading,
    this.action,
  }) : super(key: key);

  final SizingInformation info;
  final String title;
  final Widget? leading;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: R.w(info, 5), vertical: R.h(info, 1.2)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          leading != null
              ? Container(
                  height: R.w(info, 10),
                  width: R.w(info, 10),
                  alignment: Alignment.center,
                  child: leading,
                )
              : Container(
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
            child: KText(title),
          ),
          action != null
              ? Container(
                  height: R.w(info, 10),
                  width: R.w(info, 10),
                  alignment: Alignment.center,
                  child: action,
                )
              : Container(
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
