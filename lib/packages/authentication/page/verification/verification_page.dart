import 'dart:async';

import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/packages/authentication/export/export.dart';
import 'package:lottie/lottie.dart';

class VerificationPage extends StatefulWidget {
  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;
  late Timer timer;

  @override
  void initState() {
    user = _auth.currentUser!;
    user.sendEmailVerification();
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
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
      await UserOption().checkUser(user);
      final _person = await UserOption().getUserDetails(user.uid);
      context.read(personProvider).register(_person);
      Get.offAll(() => VerificationCheck());
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
                  child: KText("waiting",
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
