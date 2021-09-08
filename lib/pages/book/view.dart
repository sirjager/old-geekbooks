import 'package:geeklibrary/backend/provider/build_view.dart';
import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/constants/numers/nums.dart';
import 'package:geeklibrary/pages/book/components/column_box.dart';
import 'package:geeklibrary/pages/book/components/description_box.dart';
import 'package:geeklibrary/pages/book/components/header.dart';
import 'package:geeklibrary/pages/book/components/related.dart';
import 'package:geeklibrary/pages/book/components/row_box.dart';
import 'package:geeklibrary/pages/giver/giver.dart';
import 'package:lottie/lottie.dart';

class BookView extends StatefulWidget {
  const BookView({Key? key, required this.books, required this.book})
      : super(key: key);
  final List books;
  final Book book;

  @override
  _BookViewState createState() => _BookViewState();
}

class _BookViewState extends State<BookView> {
  bool delayed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !delayed
          ? Center(
              child: Lottie.asset(MyAssets.books, height: 400.w, onLoaded: (_) {
                Future.delayed(Duration(seconds: 2)).then((value) {
                  setState(() {
                    delayed = true;
                  });
                });
              }),
            )
          : Container(
              child: CustomScrollView(
                physics: ClampingScrollPhysics(),
                slivers: [
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: BookViewHeader(
                        book: widget.book, expandedHeight: 1300.h),
                  ),
                  buildDetailedContent(widget.book, widget.books, context,
                      context.read(themeProvider)),
                ],
              ),
            ),
    );
  }

  Widget buildDetailedContent(
      Book book, List books, BuildContext context, ThemeProvider theme) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: pad, vertical: pad * 4),
        child: FutureBuilder<Book>(
          future: Valid.verifyBuke(book),
          builder: (context, AsyncSnapshot<Book> snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Lottie.asset(MyAssets.bookLoading, height: 350.w);
            } else {
              if (snapshot.hasData) {
                Book _book = snapshot.data!;
                return buildBookBody(_book, theme, books);
              } else {
                return buildBookBody(book, theme, books);
              }
            }
          },
        ),
      ),
    );
  }

  Scrollbar buildBookBody(Book book, ThemeProvider theme, List<dynamic> books) {
    return Scrollbar(
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
                ? DescriptionBox(desc: book.desc!)
                : Container(),
            book.author != null &&
                    book.author != "" &&
                    book.author != "null" &&
                    book.author != " "
                ? ColumnBox(field: "Author", value: book.author!)
                : Container(),
            book.series != null &&
                    book.series != "" &&
                    book.series != "null" &&
                    book.series != " "
                ? ColumnBox(field: "Series", value: book.series!)
                : Container(),
            book.publisher != null &&
                    book.publisher != "" &&
                    book.publisher != "null" &&
                    book.publisher != " "
                ? ColumnBox(field: "Publisher", value: book.publisher!)
                : Container(),
            book.language != null &&
                    book.language != "" &&
                    book.language != "null" &&
                    book.language != " "
                ? RowBox(field: "Language", value: book.language!)
                : Container(),
            book.edition != null &&
                    book.edition != "" &&
                    book.edition != "null" &&
                    book.edition != " "
                ? RowBox(field: "Edition", value: book.edition!)
                : Container(),
            book.year != null &&
                    book.year != "" &&
                    book.year != "null" &&
                    book.year != " "
                ? RowBox(field: "Year", value: book.year!)
                : Container(),
            book.pages != null &&
                    book.pages != "" &&
                    book.pages != "null" &&
                    book.pages != " "
                ? RowBox(field: "Pages", value: book.pages!)
                : Container(),
            book.fileSize != null &&
                    book.fileSize != "" &&
                    book.fileSize != "null" &&
                    book.fileSize != " "
                ? RowBox(
                    field: "Size",
                    value: XMath.convertBytesToMB(book.fileSize) + " MB",
                  )
                : Container(),
            book.exten != null &&
                    book.exten != "" &&
                    book.exten != "null" &&
                    book.exten != " "
                ? RowBox(field: "Extensions", value: book.exten!)
                : Container(),
            book.md5 != null &&
                    book.md5 != "" &&
                    book.md5 != "null" &&
                    book.md5 != " "
                ? Container(
                    margin: EdgeInsets.symmetric(vertical: 100.h),
                    alignment: Alignment.center,
                    child: KClickable(
                      onPressed: () => Get.to(() => RiderProvider(book)),
                      height: 160.h,
                      width: 350.w,
                      child: KText(
                        "Download",
                        weight: FontWeight.bold,
                        size: 60.sp,
                        googleFont: GoogleFonts.mavenPro(),
                        color: Colors.black,
                      ),
                      topDeco: G.green2GradBannerDeco,
                      bottomDeco: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: XColors.darkColor2,
                      ),
                    ),
                  )
                : Container(),
            books.length < 2
                ? Container()
                : RelatedContent(books: books, notIncludeID: book.id),

            // SizedBox(height: R.h(info, 50)),
          ],
        ),
      ),
    );
  }
}
