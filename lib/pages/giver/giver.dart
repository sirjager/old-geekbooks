import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/global/titlebar/titlebar.dart';
import 'package:geeklibrary/pages/results/components/header.dart';

class RiderProvider extends StatelessWidget {
  const RiderProvider(this.book, {Key? key}) : super(key: key);
  final Book book;
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, info) {
        return Scaffold(
          body: Container(
            padding: EdgeInsets.only(top: R.statusbarHeight(info)),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    child: PageHeader(info,
                        title: book.title!, disableAction: true)),
                Expanded(
                  child: Container(
                    color: Colors.red[100],
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(book.title!),
                        
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
