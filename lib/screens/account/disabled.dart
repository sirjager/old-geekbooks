import 'package:geeklibrary/export/export.dart';

class AccountStatus extends StatelessWidget {
  const AccountStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: KText(
            "Account Disabled Contact Admin",
          ),
        ),
      ),
    );
  }
}
