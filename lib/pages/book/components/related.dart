import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/pages/book/components/bookrow.dart';

class RelatedContent extends StatelessWidget {
  const RelatedContent({
    Key? key,
    required this.books,
    required this.notIncludeID,
  }) : super(key: key);

  final String notIncludeID;
  final List books;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 60.h),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 50.w),
            child: Row(
              children: [
                Consumer(
                  builder: (context, watch, child) {
                    var isDarkMode = watch(themeProvider).isDarkMode;
                    return KText(
                      "Related Books",
                      size: 65.sp,
                      googleFont: GoogleFonts.poppins(),
                      weight: FontWeight.w500,
                      color:
                          isDarkMode ? XColors.darkColor2 : XColors.darkColor2,
                    );
                  },
                ),
              ],
            ),
          ),
          BookRow(
            books: books,
            notIncludeID: notIncludeID,
          ),
        ],
      ),
    );
  }
}
