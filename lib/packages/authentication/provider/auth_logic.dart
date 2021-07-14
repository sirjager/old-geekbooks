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
  late MyUser __user;
  MyUser get myuser => __user;
  void register(MyUser _myuser) {
    __user = _myuser;
    print("\nMyUser ${_myuser.email} has been registered\n");
    notifyListeners();
  }
}
