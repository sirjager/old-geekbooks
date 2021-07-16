import 'package:geeklibrary/export/export.dart';

class AccountStatus extends StatelessWidget {
  const AccountStatus({Key? key, this.status = ""}) : super(key: key);
  final String status;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: KText(status),
        ),
      ),
    );
  }
}
