import 'package:geeklibrary/core/log/log.dart';
import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/packages/authentication/export/export.dart';

class VerificationCheck extends StatelessWidget {
  Future<bool> checkUser() async {
    var status = FirebaseAuth.instance.currentUser!.emailVerified;
    status ? log.w('User is Verified') : log.w('User is Not Verified');
    return status;
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, info) {
        return FutureBuilder<bool>(
          future: checkUser(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                final _isUserVerified = snapshot.data!;
                if (_isUserVerified) {
                  Future.delayed(Duration(milliseconds: 100))
                      .then((value) => Get.off(() => Dashboard()));
                } else {
                  Future.delayed(Duration(milliseconds: 100))
                      .then((value) => Get.off(() => VerificationPage()));
                }
              }
            }
            return Scaffold();
          },
        );
      },
    );
  }
}
