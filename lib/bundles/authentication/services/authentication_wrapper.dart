// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class AuthenticationWrapper extends ConsumerWidget {
//   const AuthenticationWrapper(
//       {Key? key, required this.login, required this.home})
//       : super(key: key);
//   final Widget login;
//   final Widget home;

//   @override
//   Widget build(BuildContext context, ScopedReader watch) {
//     final firebaseUser = context.watch<User?>();
//     if (firebaseUser != null) {
//       return home;
//     } else {
//       return login;
//     }
//   }
// }
