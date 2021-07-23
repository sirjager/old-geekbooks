import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/widgets/kImage/kimage.dart';

class ListPage extends ConsumerWidget {
  const ListPage({Key? key, required this.books}) : super(key: key);
  final List books;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var theme = watch(themeProvider);
    var scroll = watch(scrollProvider).scroll;
    return ListView.builder(
      shrinkWrap: true,
      itemCount: books.length,
      controller: scroll,
      itemBuilder: (BuildContext context, int index) {
        final Book book = books[index];
        return SizedBox(
          height: 500.h,
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10.w),
            margin: EdgeInsets.all(10.w),
            decoration: theme.isDarkMode
                ? BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(20.w),
                  )
                : BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.w),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black38,
                          offset: Offset(1, 1),
                          blurRadius: 1),
                    ],
                  ),
            child: InkWell(
              onTap: () => Get.to(() => BookView(book: book, books: books)),
              borderRadius: BorderRadius.circular(20.w),
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    KImage(
                      borderRadius: BorderRadius.circular(20.w),
                      height: 400.h,
                      width: 230.w,
                      imageURL: book.coverURL,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(width: 40.w),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 20.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            KText(
                              book.title ?? "no title",
                              size: 40.sp,
                              maxLines: 3,
                              font: "MavenPro",
                              color:
                                  theme.isDarkMode ? Colors.white : Colors.blue,
                              overflow: TextOverflow.ellipsis,
                              weight: FontWeight.w500,
                            ),
                            SizedBox(height: 40.h),
                            KText(
                              book.author!,
                              size: 35.sp,
                              font: "MavenPro",
                              maxLines: 3,
                              color: theme.isDarkMode
                                  ? Colors.white54
                                  : Colors.blue,
                              weight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 50.h),
                            Row(
                              children: [
                                KText(
                                  "Extension : ",
                                  size: 35.sp,
                                  font: "MavenPro",
                                  maxLines: 1,
                                  color: theme.isDarkMode
                                      ? Colors.white54
                                      : Colors.blue,
                                  weight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                KText(
                                  book.exten.toString(),
                                  size: 40.sp,
                                  maxLines: 1,
                                  font: "MavenPro",
                                  color: theme.isDarkMode
                                      ? XColors.grayText
                                      : XColors.darkColor,
                                  weight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
