import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/packages/authentication/export/export.dart';
import 'package:geeklibrary/packages/authentication/functions/firestore_operation.dart';
import 'package:geeklibrary/screens/account/disabled.dart';
import 'package:lottie/lottie.dart';

class LoadUserPage extends StatelessWidget {
  final User user = FirebaseAuth.instance.currentUser!;

  Future<AccountDetails> loadAccountDetails(BuildContext context) async {
    final _accountDetails =
        await FirestoreGetOperations.getAccountDetails(user);
    if (_accountDetails.isAccountEnabled) {
      await FirestoreOperations().updateReturningUser(user);
      await FirestoreGetOperations.getAppSettings(user).then((value) {
        context.read(appsettingsProvider).register(value);
        context.read(themeProvider).setMode(value.isDarkMode!);
      });
      await FirestoreGetOperations.getPerson(user).then((value) {
        context.read(personProvider).register(value);
        context.read(accountDetailsProvider).register(_accountDetails);
      });
    }

    return FirestoreGetOperations.getAccountDetails(user);
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
                      .then((value) => Get.offAll(() => Dashboard()));
                } else {
                  Future.delayed(Duration(seconds: 2))
                      .then((value) => Get.offAll(() => AccountStatus()));
                }
              } else {}
              return Scaffold(
                body: Center(
                  child: Lottie.asset(MyAssets.check,
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
