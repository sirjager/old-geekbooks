import 'package:geekbooks/constants/numers/nums.dart';
import 'package:geekbooks/export/export.dart';
import 'package:readmore/readmore.dart';

class DescriptionBox extends ConsumerWidget {
  const DescriptionBox(this.info, {Key? key, required this.desc})
      : super(key: key);
  final String desc;
  final SizingInformation info;
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _theme = watch(themeProvider);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: pad * 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          KText(
            "Description",
            size: 25,
            color: _theme.isDarkMode ? Colors.white70 : Colors.red,
            weight: FontWeight.w900,
          ),
          ReadMoreText(
            desc,
            trimLength: 370,
            trimMode: TrimMode.Length,
            style: TextStyle(
              color: Colors.red,
              fontSize: R.f(info, 11),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
