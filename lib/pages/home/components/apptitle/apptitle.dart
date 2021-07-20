import 'package:geeklibrary/export/export.dart';

class AppTitle extends ConsumerWidget {
  const AppTitle(this.info, {Key? key, this.title = "Browse library"})
      : super(key: key);
  final SizingInformation info;
  final String title;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    bool isDarkMode = watch(themeProvider).isDarkMode;
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: R.w(info, 7), vertical: R.h(info, 2)),
      alignment: Alignment.center,
      child: Row(
        children: [
          KText(
            title,
            font: "MavenPro",
            letterSpacing: 1,
            size: R.f(info, 20),
            weight: FontWeight.w600,
            color: isDarkMode ? XColors.grayColor : Color(0xff555555),
          ),
        ],
      ),
    );
  }
}
