import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/packages/authentication/export/export.dart';
import 'package:lottie/lottie.dart';

class RefreshApp extends StatefulWidget {
  const RefreshApp({Key? key}) : super(key: key);

  @override
  _RefreshAppState createState() => _RefreshAppState();
}

class _RefreshAppState extends State<RefreshApp>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ani;

  @override
  void initState() {
    _ani = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    super.initState();
  }

  @override
  void dispose() {
    _ani.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, info) {
        return Scaffold(
          body: Center(
            child: Consumer(
              builder: (context, watch, child) {
                var _acc = watch(initializeAccountPro);
                return _acc.when(
                  data: (_account) {
                    return Lottie.asset(MyAssets.check,
                        height: R.w(info, 25), repeat: false, onLoaded: (_) {
                      setState(() => context
                          .read(themeProvider)
                          .setMode(_account.isDarkThemeEnabled));
                      _ani.forward().whenComplete(() {
                        Get.off(() => Dashboard());
                      });
                    });
                  },
                  loading: () => loadingWidget(info),
                  error: (e, s) => Text(e.toString()),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget loadingWidget(SizingInformation info) =>
      Lottie.asset(MyAssets.wave, height: R.w(info, 25));
}
