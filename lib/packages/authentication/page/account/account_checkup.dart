import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/packages/authentication/export/export.dart';
import 'package:geeklibrary/screens/account/disabled.dart';
import 'package:lottie/lottie.dart';

class AccountCheckup extends StatelessWidget {
  final User user = FirebaseAuth.instance.currentUser!;

  Future<AccountDetails> loadAccountDetails(BuildContext context) async {
    final _accountDetails =
        await FirestoreGetOperations.getAccountDetails(user);
    if (_accountDetails.isAccountEnabled) {
      return await FirestoreGetOperations.getAppSettings(user)
          .then((value) => _accountDetails);
    } else {
      return _accountDetails;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, info) {
        return FutureBuilder<AccountDetails>(
          future: loadAccountDetails(context),
          builder:
              (BuildContext context, AsyncSnapshot<AccountDetails> snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Scaffold(
                body: Center(
                  child: Lottie.asset(MyAssets.wave,
                      height: (Get.height / 100) * 25),
                ),
              );
            } else {
              if (snapshot.hasData) {
                final bool isAccountEnabled = snapshot.data!.isAccountEnabled;
                if (isAccountEnabled) {
                  Future.delayed(Duration(seconds: 2))
                      .then((value) => Get.off(() => Dashboard()));
                } else {
                  Future.delayed(Duration(seconds: 2))
                      .then((value) => Get.off(() => AccountStatus()));
                }
              } else {}
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
