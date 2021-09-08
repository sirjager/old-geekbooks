import 'package:geeklibrary/constants/numers/nums.dart';
import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/widgets/kImage/kimage.dart';

class BookRow extends StatelessWidget {
  const BookRow({Key? key, required this.books, required this.notIncludeID})
      : super(key: key);
  final List books;
  final String notIncludeID;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 700.w,
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
                  splashColor: XColors.grayColor,
                  highlightColor: XColors.grayColor,
                  onTap: () {
                    Get.back();
                    Get.to(()=> BookView(book: book, books: books));
                  },
                  child: Padding(
                    padding: EdgeInsets.all(10.w),
                    child: Consumer(
                      builder: (context, watch, child) {
                        return Container(
                          margin: EdgeInsets.all(20.w),
                          decoration: BoxDecoration(
                            border:
                                Border.all(width: 30.w, color: Colors.black),
                          ),
                          width: 410.w,
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
