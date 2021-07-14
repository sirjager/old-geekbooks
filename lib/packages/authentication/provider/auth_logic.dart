import 'package:geeklibrary/packages/authentication/export/export.dart';
import 'package:geeklibrary/export/export.dart';
// ignore: unused_import
import 'package:geeklibrary/utils/regex/reg.dart';

class PersonProvider extends ChangeNotifier {
  late Person __person;
  Person get person => __person;
  void register(Person _person) {
    __person = _person;
    print("\nPerson ${_person.email} has been registered\n");
    notifyListeners();
  }
}

class MyUserProvider extends ChangeNotifier {
  late AccountDetails __account;
  AccountDetails get accountDetails => __account;
  void register(AccountDetails _accoountDetails) {
    __account = _accoountDetails;
    print("\nMyUser ${_accoountDetails.email} has been registered\n");
    notifyListeners();
  }
}

class AppSettingsProvider extends ChangeNotifier {
  late MySettings __settings;
  MySettings get settings => __settings;
  void register(MySettings _settings) {
    __settings = _settings;
    print("\nAppSettings has been registered\n");
    notifyListeners();
  }
}
