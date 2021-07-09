import 'package:geekbooks/export/export.dart';
import 'package:geekbooks/models/download/book/book.dart';

class View extends StatelessWidget {
  const View({Key? key, required this.books, required this.id})
      : super(key: key);
  final List<Book> books;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
