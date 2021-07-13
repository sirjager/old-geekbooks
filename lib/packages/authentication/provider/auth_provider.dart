import 'package:firebase/firebase.dart';
import 'package:geekbooks/export/export.dart';
import 'package:geekbooks/packages/authentication/provider/auth_logic.dart';
import 'package:geekbooks/packages/authentication/services/authentication.dart';

final emailFieldProvider =
    ChangeNotifierProvider((ref) => EmailFieldController());

final passwordFieldProvider =
    ChangeNotifierProvider((ref) => PasswordFieldController());

final nameFieldProvider =
    ChangeNotifierProvider((ref) => NameFieldController());

final authProvider = ChangeNotifierProvider((ref) => Authentication());
