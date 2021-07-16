import 'dart:async';
import 'package:lottie/lottie.dart';
import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/packages/authentication/export/export.dart';

class VerificationPage extends StatefulWidget {
  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;
  late Timer timer;

  @override
  void initState() {
    user = _auth.currentUser!;
    if (!user.emailVerified) {
      user.sendEmailVerification();
    } else {}
    timer = Timer.periodic(Duration(seconds: 7), (timer) {
      checkEmailVerified();
    });

    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Future<void> checkEmailVerified() async {
    user = _auth.currentUser!;
    await user.reload();
    if (user.emailVerified) {
      timer.cancel();
      print("\n Email Verified = ${user.emailVerified}\n");
      Get.off(
        () => VerificationCheck(),
        transition: Transition.zoom,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveBuilder(
        builder: (context, info) {
          return Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  MyAssets.checkmail,
                  height: R.w(info, 50),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: R.h(info, 5),
                    left: R.h(info, 5),
                    right: R.h(info, 5),
                  ),
                  child: KText("check your inbox", font: "MavenPro"),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: R.h(info, 2),
                    left: R.h(info, 5),
                    right: R.h(info, 5),
                  ),
                  child: KText(
                    "We have sent verification link to your email",
                    font: "MavenPro",
                    textAlign: TextAlign.center,
                    size: R.f(info, 25),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: R.h(info, 5),
                    left: R.h(info, 5),
                    right: R.h(info, 5),
                    bottom: R.h(info, 5),
                  ),
                  child: KText("waiting for confirmation",
                      font: "MavenPro", textAlign: TextAlign.center),
                ),
                Lottie.asset(
                  MyAssets.wave,
                  height: R.w(info, 30),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
