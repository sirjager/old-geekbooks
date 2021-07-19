import 'package:geeklibrary/export/export.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var _theme = watch(themeProvider);
    return ResponsiveBuilder(
      builder: (context, info) {
        return Scaffold(
          body: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 0,
                left: 0,
                child: Image.asset("assets/images/shapes/main_top.png",
                    width: R.w(info, 40)),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Image.asset(
                  "assets/images/shapes/main_bottom.png",
                  width: R.w(info, 30),
                ),
              ),
              WelcomeBody(info),
            ],
          ),
        );
      },
    );
  }
}

class WelcomeBody extends StatelessWidget {
  const WelcomeBody(this.info, {Key? key}) : super(key: key);
  final SizingInformation info;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      // child:Image.asset(name)
    );
  }
}
