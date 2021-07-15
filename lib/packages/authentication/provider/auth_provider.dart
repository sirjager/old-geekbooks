import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geeklibrary/packages/authentication/export/export.dart';
import 'package:geeklibrary/packages/authentication/functions/firestore_operations.dart';

final authInstance = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final auth =
    Provider<Authentication>((ref) => Authentication(ref.read(authInstance)));

final authState =
    StreamProvider<User?>((ref) => ref.watch(auth).authStateChanges);

final accountProvider = ChangeNotifierProvider((ref) => MyAccount());
