import 'package:flutter/cupertino.dart';
import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/global/titlebar/titlebar.dart';

class Homepage extends StatelessWidget {
  Homepage(this.info, {Key? key}) : super(key: key);
  final SizingInformation info;
  final FocusNode _node = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(
        horizontal: R.w(info, 1),
        vertical: R.statusbarHeight(info),
      ),
      child: Column(
        children: [
          Titlebar(info),
          AppTitle(info),
          Searchbar(info, _node),
         
          SearchOptions(info),
        ],
      ),
    );
  }
}
