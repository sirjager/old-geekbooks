import 'package:geekbooks/bundles/authentication/export/export.dart';
import 'package:geekbooks/bundles/authentication/page/verification/verification_page.dart';
import 'package:geekbooks/core/log/log.dart';
import 'package:geekbooks/export/export.dart';

class VerificationCheck extends StatelessWidget {
  Future<bool> checkUser() async {
    var status = FirebaseAuth.instance.currentUser!.emailVerified;
    status ? log.w('User is Verified') : log.w('User is Not Verified');
    return status;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: checkUser(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            if (snapshot.data == true)
              Future.delayed(Duration(milliseconds: 100))
                  .then((value) => Get.off(() => Dashboard()));
            else
              Future.delayed(Duration(milliseconds: 100))
                  .then((value) => Get.off(() => VerificationPage()));
          }
        }
        return Scaffold();
      },
    );
  }
}
