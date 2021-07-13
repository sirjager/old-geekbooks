import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geekbooks/bundles/authentication/provider/auth_logic.dart';
import 'package:geekbooks/bundles/authentication/services/authentication.dart';

final emailFieldProvider =
    ChangeNotifierProvider((ref) => EmailFieldController());

final passwordFieldProvider =
    ChangeNotifierProvider((ref) => PasswordFieldController());

final nameFieldProvider =
    ChangeNotifierProvider((ref) => NameFieldController());

final authProvider = ChangeNotifierProvider((ref) => Authentication());
