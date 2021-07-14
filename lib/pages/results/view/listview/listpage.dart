import 'package:geeklibrary/constants/numers/nums.dart';
import 'package:geeklibrary/export/export.dart';

import 'package:geeklibrary/widgets/kImage/kimage.dart';

class ListPage extends ConsumerWidget {
  const ListPage(this.info, {Key? key, required this.books}) : super(key: key);
  final List books;
  final SizingInformation info;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var theme = watch(themeProvider);
    return ListView.builder(
      shrinkWrap: true,
      itemCount: books.length,
      itemBuilder: (BuildContext context, int index) {
        final Book book = books[index];
        return Container(
          padding: const EdgeInsets.all(pad),
          margin: const EdgeInsets.all(pad),
          decoration: theme.isDarkMode
              ? BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(24),
                )
              : BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black38,
                        offset: Offset(1, 1),
                        blurRadius: 1),
                  ],
                ),
          child: InkWell(
            onTap: () => Get.to(() => BookView(book: book, books: books)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: KImage(
                      borderRadius: BorderRadius.circular(11),
                      height: R.w(info, 30),
                      width: R.w(info, 20),
                      imageURL: book.coverURL,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: pad / 2),
                    margin: const EdgeInsets.symmetric(vertical: pad),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        KText(
                          book.title,
                          size: 15,
                          maxLines: 4,
                          color: theme.isDarkMode ? Colors.white : Colors.blue,
                          weight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: pad * 2),
                        KText(
                          book.author!,
                          size: 10,
                          maxLines: 5,
                          color:
                              theme.isDarkMode ? Colors.white54 : Colors.blue,
                          weight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
