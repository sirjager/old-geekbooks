import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/packages/authentication/export/export.dart';
import 'package:geeklibrary/packages/authentication/page/account/account_checkup.dart';
import 'package:lottie/lottie.dart';

final _isVerifiedPro = FutureProvider<bool>((ref) async {
  User _user = FirebaseAuth.instance.currentUser!;
  await _user.reload();
  return _user.emailVerified;
});

class VerificationCheck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, info) {
        return Scaffold(
          body: Center(
            child: Consumer(
              builder: (context, watch, child) {
                var isverified = watch(_isVerifiedPro);
                return isverified.when(
                  data: (verified) {
                    if (verified) {
                      Future.delayed(Duration(seconds: 1))
                          .then((value) => Get.off(() => AccountCheckup()));
                      return Text("User is Verified");
                    } else {
                      Future.delayed(Duration(seconds: 1))
                          .then((value) => Get.off(() => VerificationPage()));
                      return Text("User Not Verified");
                    }
                  },
                  loading: () => Lottie.asset(MyAssets.wave,
                      height: (Get.height / 100) * 25),
                  error: (e, s) => Text(e.toString()),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
