import 'package:geeklibrary/constants/numers/nums.dart';
import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/widgets/kImage/kimage.dart';

class BookRow extends StatelessWidget {
  const BookRow(this.info,
      {Key? key, required this.books, required this.notIncludeID})
      : super(key: key);
  final List books;
  final String notIncludeID;
  final SizingInformation info;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: R.h(info, 29),
      width: double.infinity,
      child: ListView.builder(
        physics: ClampingScrollPhysics(),
        itemCount: books.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          var book = books[index];
          if (book.id != notIncludeID) {
            return Padding(
              padding: const EdgeInsets.all(pad),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: Colors.red,
                  highlightColor: Colors.red,
                  onTap: () {
                    Get.back();
                    Get.to(BookView(book: book, books: books));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(1),
                    child: Consumer(
                      builder: (context, watch, child) {
                        return Container(
                          margin: const EdgeInsets.all(pad / 2),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: pad,
                              color: Colors.black,
                            ),
                          ),
                          width: R.w(info, 37),
                          child: KImage(
                            fit: BoxFit.fill,
                            imageURL: book.coverURL,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
