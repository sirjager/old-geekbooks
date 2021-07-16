import 'package:geeklibrary/export/export.dart';

class BookProvider {
  List<Book> build(List<dynamic> dataList) {
    List<Book> bookList = [];
    for (var json in dataList) {
      Book _book = Book.build(json);
      bookList.add(_book);
    }
    return bookList;
  }
}
