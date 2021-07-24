import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/widgets/chip/chip.dart';

class SearchOptions extends ConsumerWidget {
  SearchOptions({Key? key}) : super(key: key);

  final List<KItem> filters = [
    KItem(index: 0, title: "Default", active: false, value: "def"),
    KItem(index: 1, title: "Title", active: false, value: "title"),
    KItem(index: 2, title: "Author", active: false, value: "author"),
    KItem(index: 3, title: "Series", active: false, value: "series"),
    KItem(index: 4, title: "Year", active: false, value: "year"),
    KItem(index: 5, title: "Publisher", active: false, value: "publisher"),
    KItem(index: 6, title: "Language", active: false, value: "language"),
  ];

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var searchOption = watch(searchOptionProvider);
    var theme = watch(themeProvider);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 50.h, horizontal: 10.w),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 50.w, vertical: 10.w),
            child: Row(
              children: [
                KText(
                  "search in field",
                  font: "Nunito",
                  weight: FontWeight.w600,
                  size: 60.sp,
                  color: theme.isDarkMode
                      ? XColors.grayColor.withOpacity(0.5)
                      : XColors.darkColor.withOpacity(0.5),
                ),
              ],
            ),
          ),
          Wrap(
            children: filters.map(
              (item) {
                bool isSelected = searchOption.selected.index == item.index;
                return Container(
                  padding: EdgeInsets.all(10.w),
                  child: KClickable(
                    isPressed: isSelected,
                    height: 130.h,
                    width: 230.w,
                    onPressed: () => updateFilter(item.index, searchOption),
                    child: KText(
                      item.title.toString(),
                      font: "MavenPro",
                      letterSpacing: 1,
                      size: 38.sp,
                      color: isSelected ? XColors.darkText : XColors.grayText,
                      weight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    ),
                    topDeco: BoxDecoration(
                      color: theme.isDarkMode
                          ? XColors.darkColor1
                          : XColors.lightColor1,
                      borderRadius: BorderRadius.circular(0.w),
                    ),
                    bottomDeco: BoxDecoration(
                      color: theme.isDarkMode
                          ? XColors.darkGray.withOpacity(0.4)
                          : XColors.grayText,
                      borderRadius: BorderRadius.circular(0.w),
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }

  bool updateFilter(int index, SearchOptionProvider searchOption) {
    var _filterList = filters;
    for (KItem item in _filterList) {
      if (index == item.index) {
        searchOption.setSelection(item);
      }
    }
    return true;
  }
}
