import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/packages/authentication/export/export.dart';
import 'package:geeklibrary/packages/authentication/page/account/account_checkup.dart';
import 'package:lottie/lottie.dart';

class VerificationCheck extends StatelessWidget {
  Future<bool> checkUser() async =>
      FirebaseAuth.instance.currentUser!.emailVerified;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, info) {
        return FutureBuilder<bool>(
          future: checkUser(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Scaffold(
                body: Center(
                  child: Lottie.asset(MyAssets.wave,
                      repeat: false, height: (Get.height / 100) * 35),
                ),
              );
            } else {
              if (snapshot.hasData) {
                final _isUserVerified = snapshot.data!;
                if (_isUserVerified) {
                  Future.delayed(Duration(seconds: 3))
                      .then((value) => Get.offAll(() => AccountCheckup()));
                } else {
                  Future.delayed(Duration(seconds: 3))
                      .then((value) => Get.offAll(() => VerificationPage()));
                }
              }
              return Scaffold(
                body: Center(
                  child: Lottie.asset(MyAssets.wave,
                      height: (Get.height / 100) * 25),
                ),
              );
            }
          },
        );
      },
    );
  }
}
