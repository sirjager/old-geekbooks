import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geekbooks/bundles/authentication/export/export.dart';
import 'package:geekbooks/bundles/authentication/provider/auth_logic.dart';
import 'package:geekbooks/bundles/authentication/services/authentication.dart';

final emailFieldProvider =
    ChangeNotifierProvider((ref) => EmailFieldController());
final passwordFieldProvider =
    ChangeNotifierProvider((ref) => PasswordFieldController());
final nameFieldProvider =
    ChangeNotifierProvider((ref) => NameFieldController());

final authInstance = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final auth =
    Provider<Authentication>((ref) => Authentication(ref.read(authInstance)));

final authState =
    StreamProvider<User?>((ref) => ref.watch(auth).authStateChanges);
