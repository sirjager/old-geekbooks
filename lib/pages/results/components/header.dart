import 'package:geekbooks/export/export.dart';
import 'package:geekbooks/global/titlebar/titlebar.dart';

class PageHeader extends StatelessWidget {
  const PageHeader(this.info, {Key? key, required this.query})
      : super(key: key);
  final SizingInformation info;
  final String query;

  @override
  Widget build(BuildContext context) {
    return Titlebar(
      info,
      title: query,
      leading: IconButton(
          onPressed: () => Get.back(), icon: Icon(EvaIcons.arrowIosBack)),
      action: Consumer(
        builder: (context, watch, child) {
          var view = watch(gridViewProvider);
          return IconButton(
            onPressed: () => view.toggleGrid(),
            icon: Icon(view.isGrid ? EvaIcons.gridOutline : EvaIcons.list),
          );
        },
      ),
    );
  }
}
