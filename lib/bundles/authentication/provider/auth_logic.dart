import 'package:geekbooks/export/export.dart';
import 'package:geekbooks/utils/regex/reg.dart';
import 'package:string_validator/string_validator.dart';

class EmailFieldController extends ChangeNotifier {
  //! private
  String __email = "";
  bool _isvalid = false;
  bool _islocked = false;
  TextEditingController _emailController = TextEditingController();

  //* public
  String get email => __email;
  bool get isValid => _isvalid;
  bool get isLocked => _islocked;
  TextEditingController get controller => _emailController;

  void setEmail(String email, {bool lock = false}) {
    _islocked = lock;
    _isvalid = isEmail(email);
    if (isValid) {
      __email = email;
      _emailController.text = email;
      print("Email is valid: $email");
    }
    notifyListeners();
  }
}

class PasswordFieldController extends ChangeNotifier {
  TextEditingController _passwordController = TextEditingController();
  TextEditingController get controller => _passwordController;
  //!private

  bool _islocked = false;

  //* public

  bool get isLocked => _islocked;

  void setPassword(String password, {bool lock = false}) {
    _islocked = lock;
    if (password.length > 7) {
      _passwordController.text = password;
    }
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
