import 'package:geekbooks/export/export.dart';
import 'package:geekbooks/global/titlebar/titlebar.dart';

class PageHeader extends StatelessWidget {
  const PageHeader(this.info,
      {Key? key, required this.title, this.disableAction = false})
      : super(key: key);
  final SizingInformation info;
  final String title;
  final bool disableAction;

  @override
  Widget build(BuildContext context) {
    return Titlebar(
      info,
      title: title,
      disableAction: disableAction,
      leading: IconButton(
          splashColor: Colors.transparent,
          onPressed: () => Get.back(),
          icon: Icon(EvaIcons.arrowIosBack)),
      action: disableAction
          ? null
          : Consumer(
              builder: (context, watch, child) {
                var view = watch(gridViewProvider);
                return IconButton(
                  onPressed: () => view.toggleGrid(),
                  splashColor: Colors.transparent,
                  icon:
                      Icon(view.isGrid ? EvaIcons.gridOutline : EvaIcons.list),
                );
              },
            ),
    );
  }
}
