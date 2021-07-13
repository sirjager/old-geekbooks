import 'package:geekbooks/export/export.dart';
import 'package:geekbooks/packages/authentication/provider/auth_logic.dart';

final emailFieldProvider =
    ChangeNotifierProvider((ref) => EmailFieldController());

final passwordFieldProvider =
    ChangeNotifierProvider((ref) => PasswordFieldController());

final nameFieldProvider =
    ChangeNotifierProvider((ref) => NameFieldController());
