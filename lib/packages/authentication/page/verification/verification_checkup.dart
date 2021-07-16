import 'package:lottie/lottie.dart';
import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/packages/authentication/export/export.dart';

class VerificationCheck extends StatelessWidget {
  Future<bool> _emailVerified() async {
    User _user = FirebaseAuth.instance.currentUser!;
    await _user.reload();
    return _user.emailVerified;
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, info) {
        return Scaffold(
          body: Center(
            child: FutureBuilder(
              future: _emailVerified(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return Lottie.asset(MyAssets.wave, height: R.w(info, 25));
                } else {
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else if (!snapshot.hasData) {
                    return Text("No Data Found");
                  } else if (snapshot.hasData) {
                    if (snapshot.data == true) {
                      return Text(
                          "Email is Verified  = ${snapshot.data.toString()}");
                    } else {
                      return Text(
                          "Email is Not Verified = ${snapshot.data.toString()}");
                    }
                  } else {
                    return Text(snapshot.hashCode.toString());
                  }
                }
              },
            ),
          ),
        );
      },
    );
  }
}
