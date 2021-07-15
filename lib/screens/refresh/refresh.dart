import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/packages/authentication/export/export.dart';

class RefreshApp extends StatefulWidget {
  const RefreshApp({Key? key}) : super(key: key);

  @override
  _RefreshAppState createState() => _RefreshAppState();
}

class _RefreshAppState extends State<RefreshApp> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, info) {
        return Consumer(
          builder: (context, watch, child) {
            var _acc = watch(initializeAccountPro);
            return _acc.when(
              data: (_account) {
                context
                    .read(themeProvider)
                    .setMode(_account.isDarkThemeEnabled);
                Future.delayed(Duration(seconds: 2))
                    .then((value) => Get.off(() => Dashboard()));
                return Scaffold(
                    body: Center(child: CircularProgressIndicator()));
              },
              loading: () =>
                  Scaffold(body: Center(child: CircularProgressIndicator())),
              error: (e, s) =>
                  Scaffold(body: Center(child: Text(e.toString()))),
            );
          },
        );
      },
    );
  }
}
