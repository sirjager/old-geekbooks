import 'package:geeklibrary/export/export.dart';

class Navigationbar extends ConsumerWidget {
  const Navigationbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    watch(navigationProvider);
    var _theme = watch(themeProvider);
    final List<NavItem> _nav = [
      NavItem(0, EvaIcons.searchOutline, 'Search'),
      NavItem(1, EvaIcons.settingsOutline, 'Settings'),
    ];
    var children = _nav
        .map((e) => InkWell(
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () => context.read(navigationProvider).changeTo(e.index),
              child: Container(
                margin: EdgeInsets.all(2.w),
                padding: EdgeInsets.symmetric(vertical: 50.w, horizontal: 50.w),
                child: Icon(
                  e.icon,
                  color: context.read(navigationProvider).current == e.index
                      ? Theme.of(context).primaryColor
                      : _theme.isDarkMode
                          ? Colors.white38
                          : Colors.black38,
                  size: context.read(navigationProvider).current == e.index
                      ? 80.w
                      : 60.w,
                ),
              ),
            ))
        .toList();

    return Container(
      height: 180.h,
      margin: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }
}

class NavItem {
  NavItem(this.index, this.icon, this.title);
  final int index;
  final IconData icon;
  final String title;
}
