import 'package:geekbooks/export/export.dart';
import 'package:geekbooks/widgets/chip/chip.dart';

class SearchOptions extends ConsumerWidget {
  SearchOptions(this.info, {Key? key}) : super(key: key);
  final SizingInformation info;

  final List<KItem> filters = [
    KItem(index: 0, title: "Simple", active: false),
    KItem(index: 1, title: "Title", active: false),
    KItem(index: 2, title: "Author", active: false),
    KItem(index: 3, title: "Year", active: false),
    KItem(index: 4, title: "Publisher", active: false),
    KItem(index: 5, title: "Tags", active: false),
  ];

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var searchOption = watch(searchOptionProvider);

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
                  color: isSelected ? Color(0xff555555) : XColors.grayText,
                  weight: isSelected ? FontWeight.w700 : FontWeight.w400,
                ),
                topDeco: BoxDecoration(
                  color: Color(0xffF8F8FA),
                  borderRadius: BorderRadius.circular(15),
                ),
                bottomDeco: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }

  Future<bool> updateFilter(
      int index, SearchOptionProvider searchOption) async {
    var _filterList = filters;
    for (KItem item in _filterList) {
      if (index == item.index) {
        searchOption.setSelection(item);
        print(item.title);
      }
    }

    return true;
  }
}
