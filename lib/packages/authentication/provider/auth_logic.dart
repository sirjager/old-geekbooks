import 'package:geeklibrary/packages/authentication/export/export.dart';
import 'package:geeklibrary/export/export.dart';
// ignore: unused_import
import 'package:geeklibrary/utils/regex/reg.dart';

class PersonProvider extends ChangeNotifier {
  late Person __person;
  Person get person => __person;
  void register(Person _person) {
    __person = _person;
    print("\nUser ${_person.email} has been registered\n");
    notifyListeners();
  }
}
