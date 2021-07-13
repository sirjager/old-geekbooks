import 'package:geekbooks/export/export.dart';
import 'package:geekbooks/utils/regex/reg.dart';
import 'package:string_validator/string_validator.dart';

class EmailFieldController extends ChangeNotifier {
  TextEditingController _emailController = TextEditingController();
  TextEditingController get controller => _emailController;
  //! private
  bool _isvalid = false;
  bool _islocked = false;

  //* public
  bool get isValid => _isvalid;
  bool get isLocked => _islocked;
  void setEmail(String email, {bool lock = false}) {
    _islocked = lock;
    _emailController.text = email;
    _isvalid = isEmail(email);
    if (isValid) {
      print("Email is valid: $email");
    }
    notifyListeners();
  }
}

class PasswordFieldController extends ChangeNotifier {
  TextEditingController _passwordController = TextEditingController();
  TextEditingController get controller => _passwordController;
  //!private
  bool _isstrong = false;
  bool _islocked = false;

  //* public
  bool get isStrong => _isstrong;
  bool get isLocked => _islocked;

  void setPassword(String password, {bool lock = false}) {
    _islocked = lock;
    _isstrong = XReg.strongPassword.hasMatch(password);
    _passwordController.text = password;
    notifyListeners();
  }
}

class NameFieldController extends ChangeNotifier {
  TextEditingController _nameController = TextEditingController();
  TextEditingController get controller => _nameController;
  //!private
  bool _islocked = false;
  //* public
  bool get isLocked => _islocked;
  void setName(String name, {bool lock = false}) {
    _islocked = lock;
    _nameController.text = name;
    notifyListeners();
  }
}
