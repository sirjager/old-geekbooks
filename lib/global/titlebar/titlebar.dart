import 'package:geeklibrary/export/export.dart';

class Titlebar extends ConsumerWidget {
  const Titlebar(
    this.info, {
    Key? key,
    this.title = "",
    this.leading,
    this.action,
    this.disableAction = false,
    this.decoration,
    this.margin,
  }) : super(key: key);

  final SizingInformation info;
  final String title;
  final Widget? leading;
  final Widget? action;
  final BoxDecoration? decoration;
  final bool disableAction;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var isDarkMode = watch(themeProvider).isDarkMode;
    return Container(
      padding: margin ??
          EdgeInsets.symmetric(
            horizontal: R.w(info, 5),
            vertical: R.h(info, 1.2),
          ),
      decoration: decoration ?? BoxDecoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          leading != null
              ? Container(
                  height: R.w(info, 10),
                  width: R.w(info, 10),
                  clipBehavior: Clip.antiAlias,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: leading,
                )
              : Container(
                  height: R.w(info, 10),
                  width: R.w(info, 10),
                  alignment: Alignment.center,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: Consumer(
                      builder: (context, watch, child) {
                        var scaf = watch(drawerProvider);
                        return IconButton(
                          splashColor: Colors.transparent,
                          onPressed: () =>
                              scaf.scaffoldKey.currentState!.openDrawer(),
                          iconSize: R.w(info, 6),
                          icon: Icon(EvaIcons.barChartOutline),
                          color: isDarkMode
                              ? XColors.grayText
                              : XColors.darkColor1,
                        );
                      },
                    ),
                  ),
                ),
          SizedBox(width: R.w(info, 5)),
          Expanded(
            child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: KText(
                title,
                color: isDarkMode ? XColors.grayText : XColors.darkColor1,
              ),
            ),
          ),
          action != null
              ? Container(
                  height: R.w(info, 10),
                  width: R.w(info, 10),
                  alignment: Alignment.center,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: action,
                )
              : disableAction
                  ? Container()
                  : Container(
                      height: R.w(info, 10),
                      width: R.w(info, 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: Stack(
                        children: [
                          IconButton(
                            splashColor: Colors.transparent,
                            onPressed: () {},
                            iconSize: R.w(info, 6),
                            icon: Icon(EvaIcons.bellOutline),
                            color: isDarkMode
                                ? XColors.grayText
                                : XColors.darkColor1,
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
