import 'package:geeklibrary/backend/provider/build_view.dart';
import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/constants/numers/nums.dart';
import 'package:geeklibrary/pages/book/components/column_box.dart';
import 'package:geeklibrary/pages/book/components/description_box.dart';
import 'package:geeklibrary/pages/book/components/header.dart';
import 'package:geeklibrary/pages/book/components/related.dart';
import 'package:geeklibrary/pages/book/components/row_box.dart';
import 'package:geeklibrary/pages/giver/giver.dart';
import 'package:geeklibrary/widgets/kbuttons/kleaf_button.dart';
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
      body: ResponsiveBuilder(
        builder: (context, info) {
          return !delayed
              ? Center(
                  child: Lottie.asset(MyAssets.books, height: R.w(info, 35),
                      onLoaded: (_) {
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
                          info,
                          book: widget.book,
                          expandedHeight: R.h(info, 55),
                        ),
                      ),
                      buildDetailedContent(widget.book, widget.books, context,
                          context.read(themeProvider), info),
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
        margin: const EdgeInsets.symmetric(horizontal: pad, vertical: pad * 4),
        child: FutureBuilder<Book>(
          future: Valid.verifyBuke(book),
          builder: (context, AsyncSnapshot<Book> snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Lottie.asset(MyAssets.bookLoading, height: R.w(info, 35));
            } else {
              if (snapshot.hasData) {
                Book _book = snapshot.data!;
                return buildBookBody(_book, info, theme, books);
              } else {
                return buildBookBody(book, info, theme, books);
              }
            }
          },
        ),
      ),
    );
  }

  Scrollbar buildBookBody(Book book, SizingInformation info,
      ThemeProvider theme, List<dynamic> books) {
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
                ? ColumnBox(info, field: "Publisher", value: book.publisher!)
                : Container(),
            book.language != null &&
                    book.language != "" &&
                    book.language != "null" &&
                    book.language != " "
                ? RowBox(info, field: "Language", value: book.language!)
                : Container(),
            book.edition != null &&
                    book.edition != "" &&
                    book.edition != "null" &&
                    book.edition != " "
                ? RowBox(info, field: "Edition", value: book.edition!)
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
            book.fileSize != null &&
                    book.fileSize != "" &&
                    book.fileSize != "null" &&
                    book.fileSize != " "
                ? RowBox(
                    info,
                    field: "Size",
                    value: XMath.convertBytesToMB(book.fileSize) + " MB",
                  )
                : Container(),
            book.exten != null &&
                    book.exten != "" &&
                    book.exten != "null" &&
                    book.exten != " "
                ? RowBox(info, field: "Extensions", value: book.exten!)
                : Container(),
            book.md5 != null &&
                    book.md5 != "" &&
                    book.md5 != "null" &&
                    book.md5 != " "
                ? Container(
                    margin: EdgeInsets.only(
                        top: R.h(info, 5), bottom: R.h(info, 5)),
                    alignment: Alignment.center,
                    child: KLeafButton(
                      onPressed: () => Get.to(() => RiderProvider(book)),
                      height: R.w(info, 15),
                      width: R.w(info, 45),
                      icon: Ionicons.download_outline,
                      iconColor: theme.isDarkMode
                          ? XColors.grayText1
                          : XColors.grayText,
                      child: KText(
                        "Get it",
                        font: "MavenPro",
                        weight: FontWeight.bold,
                        size: R.f(info, 15),
                        color: theme.isDarkMode
                            ? XColors.lightColor1
                            : XColors.lightColor1,
                      ),
                      radius: 0,
                      color1: theme.isDarkMode
                          ? XColors.grayText1
                          : XColors.grayText,
                    ),
                  )
                : Container(),
            RelatedContent(info, books: books, notIncludeID: book.id),

            // SizedBox(height: R.h(info, 50)),
          ],
        ),
      ),
    );
  }
}
