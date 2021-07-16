import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/constants/numers/nums.dart';
import 'package:geeklibrary/pages/book/components/column_box.dart';
import 'package:geeklibrary/pages/book/components/description_box.dart';
import 'package:geeklibrary/pages/book/components/header.dart';
import 'package:geeklibrary/pages/book/components/related.dart';
import 'package:geeklibrary/pages/book/components/row_box.dart';
import 'package:geeklibrary/widgets/kbuttons/kleaf_button.dart';

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
              physics: ClampingScrollPhysics(),
              slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  delegate: BookViewHeader(info,
                      book: book, expandedHeight: R.h(info, 55)),
                ),
                buildDetailedContent(
                    book, books, context, context.read(themeProvider), info),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildDetailedContent(Book book, List books, BuildContext context,
      ThemeProvider theme, SizingInformation info) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: pad, vertical: pad * 5),
        child: Scrollbar(
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                book.desc != null &&
                        book.desc != "" &&
                        book.desc != "null" &&
                        book.desc != " "
                    ? DescriptionBox(info, desc: book.desc!)
                    : Container(),
                book.author != null &&
                        book.author != "" &&
                        book.author != "null" &&
                        book.author != " "
                    ? ColumnBox(info, field: "Author", value: book.author!)
                    : Container(),
                book.series != null &&
                        book.series != "" &&
                        book.series != "null" &&
                        book.series != " "
                    ? ColumnBox(info, field: "Series", value: book.series!)
                    : Container(),
                book.publisher != null &&
                        book.publisher != "" &&
                        book.publisher != "null" &&
                        book.publisher != " "
                    ? ColumnBox(info,
                        field: "Publisher", value: book.publisher!)
                    : Container(),
                book.language != null &&
                        book.language != "" &&
                        book.language != "null" &&
                        book.language != " "
                    ? RowBox(info, field: "Language", value: book.language!)
                    : Container(),
                book.year != null &&
                        book.year != "" &&
                        book.year != "null" &&
                        book.year != " "
                    ? RowBox(info, field: "Year", value: book.year!)
                    : Container(),
                book.pages != null &&
                        book.pages != "" &&
                        book.pages != "null" &&
                        book.pages != " "
                    ? RowBox(info, field: "Pages", value: book.pages!)
                    : Container(),
                book.md5 != null &&
                        book.md5 != "" &&
                        book.md5 != "null" &&
                        book.md5 != " "
                    ? Container(
                        margin: const EdgeInsets.all(pad),
                        alignment: Alignment.center,
                        child: KLeafButton(
                          onPressed: () {
                            // Get.to(() => DownloadPage(
                            //     book.downloads, book.title!, book.exten!));
                          },
                          height: R.w(info, 15),
                          width: R.w(info, 45),
                          icon: Ionicons.cloud_download_outline,
                          iconColor:
                              theme.isDarkMode ? Colors.black : Colors.green,
                          child: KText(
                            "Download",
                            weight: FontWeight.bold,
                            size: R.f(info, 10),
                            color: Colors.black,
                          ),
                        ),
                      )
                    : Container(),
                RelatedContent(info, books: books, notIncludeID: book.id),

                // SizedBox(height: R.h(info, 50)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
