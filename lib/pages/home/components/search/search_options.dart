import 'package:geekbooks/export/export.dart';
import 'package:geekbooks/widgets/chip/chip.dart';

class SearchOptions extends ConsumerWidget {
  SearchOptions(this.info, {Key? key}) : super(key: key);
  final SizingInformation info;

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
      margin: EdgeInsets.symmetric(
          vertical: R.h(info, 2), horizontal: R.w(info, 2)),
      child: Wrap(
        children: filters.map(
          (item) {
            bool isSelected = searchOption.selected.index == item.index;
            return Container(
              margin: const EdgeInsets.all(5),
              child: KClickable(
                isPressed: isSelected,
                height: R.h(info, 5),
                width: R.w(info, 20),
                onPressed: () => updateFilter(item.index, searchOption),
                child: KText(
                  item.title.toString(),
                  font: "MavenPro",
                  letterSpacing: 1,
                  size: R.f(info, 10),
                  color: isSelected ? XColors.darkText : XColors.grayText,
                  weight: isSelected ? FontWeight.w700 : FontWeight.w500,
                ),
                topDeco: BoxDecoration(
                  color: theme.isDarkMode
                      ? XColors.darkColor1
                      : XColors.lightColor1,
                  borderRadius: BorderRadius.circular(15),
                ),
                bottomDeco: BoxDecoration(
                  color:
                      theme.isDarkMode ? XColors.darkColor2 : XColors.grayText,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            );
          },
        ).toList(),
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
