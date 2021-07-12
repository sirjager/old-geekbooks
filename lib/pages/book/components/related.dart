import 'package:geekbooks/export/export.dart';
import 'package:geekbooks/pages/book/components/bookrow.dart';

class RelatedContent extends StatelessWidget {
  const RelatedContent(
    this.info, {
    Key? key,
    required this.books,
    required this.notIncludeID,
  }) : super(key: key);

  final SizingInformation info;
  final String notIncludeID;
  final List books;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: R.h(info, 2)),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: R.w(info, 5)),
            child: Row(
              children: [
                KText(
                  "Related Books",
                  size: R.f(info, 17),
                  font: "Poppins",
                  weight: FontWeight.w500,
                ),
              ],
            ),
          ),
          BookRow(
            info,
            books: books,
            notIncludeID: notIncludeID,
          ),
        ],
      ),
    );
  }
}
