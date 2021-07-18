import 'package:geeklibrary/export/export.dart';

class NavigationMobile extends ConsumerWidget {
  const NavigationMobile(this.info, {Key? key}) : super(key: key);
  final SizingInformation info;
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
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: R.h(info, 2),
                    horizontal: R.w(info, 4),
                  ),
                  child: Icon(
                    e.icon,
                    color: context.read(navigationProvider).current == e.index
                        ? Theme.of(context).primaryColor
                        : _theme.isDarkMode
                            ? Colors.white38
                            : Colors.black38,
                    size: context.read(navigationProvider).current == e.index
                        ? R.w(info, 7)
                        : R.w(info, 5),
                  ),
                ),
              ),
            ))
        .toList();

    return Container(
      height: R.h(info, 7),
      width: double.infinity,
      child: SingleChildScrollView(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: children,
        ),
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
