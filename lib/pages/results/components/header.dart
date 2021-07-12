import 'package:geekbooks/export/export.dart';
import 'package:geekbooks/global/titlebar/titlebar.dart';

class PageHeader extends ConsumerWidget {
  const PageHeader(this.info,
      {Key? key, required this.title, this.disableAction = false})
      : super(key: key);
  final SizingInformation info;
  final String title;
  final bool disableAction;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var view = watch(gridViewProvider);
    var isDarkMode = watch(themeProvider).isDarkMode;
    return Titlebar(
      info,
      title: title,
      disableAction: disableAction,
      leading: IconButton(
        splashColor: Colors.transparent,
        onPressed: () => Get.back(),
        icon: Icon(EvaIcons.arrowIosBack),
        color: isDarkMode ? XColors.grayText : XColors.darkColor1,
      ),
      action: disableAction
          ? null
          : IconButton(
              onPressed: () => view.toggleGrid(),
              splashColor: Colors.transparent,
              icon: Icon(view.isGrid ? EvaIcons.gridOutline : EvaIcons.list),
              color: isDarkMode ? XColors.grayText : XColors.darkColor1,
            ),
    );
  }
}
