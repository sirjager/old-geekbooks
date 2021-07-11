import 'package:geekbooks/constants/numers/nums.dart';
import 'package:geekbooks/export/export.dart';

class RowBox extends ConsumerWidget {
  final String field;
  final String value;
  final SizingInformation info;

  RowBox(this.info, {required this.value, required this.field});

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _theme = watch(themeProvider);
    return Container(
      margin:
          const EdgeInsets.only(top: pad * 2, left: pad * 2, right: pad * 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          KText(
            field,
            size: 25,
            color: _theme.isDarkMode ? Colors.white70 : Colors.red,
            weight: FontWeight.w900,
          ),
          SizedBox(width: pad),
          KText(
            value,
            size: 20,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            color: Colors.red,
            weight: FontWeight.w400,
          ),
        ],
      ),
    );
  }
}
