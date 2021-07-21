import 'package:geeklibrary/packages/authentication/export/export.dart';
import 'package:geeklibrary/export/export.dart';
// ignore: unused_import
import 'package:geeklibrary/utils/regex/reg.dart';

class MyAccount extends ChangeNotifier {
  late AccountDetails __accounT;
  AccountDetails get account => __accounT;
  void register(AccountDetails _account) {
    __accounT = _account;
    print("\nAccount Details For ${_account.email} has been registered\n");
    notifyListeners();
  }
}
