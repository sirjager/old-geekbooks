import 'package:geekbooks/export/export.dart';
import 'package:geekbooks/pages/book/components/header.dart';

class BookView extends StatelessWidget {
  const BookView({Key? key, required this.books, required this.book})
      : super(key: key);
  final List books;
  final Book book;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveBuilder(
        builder: (context, info) {
          return Container(
            child: CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  delegate: BookViewHeader(info,
                      book: book, expandedHeight: R.h(info, 50)),
                ),
                // buildDetailedContent(book, widget.results, context, _theme),
              ],
            ),
          );
        },
      ),
    );
  }
}
