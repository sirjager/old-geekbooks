import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:geeklibrary/packages/authentication/export/export.dart';

class AuthenticationWrapper extends ConsumerWidget {
  const AuthenticationWrapper(
      {Key? key, required this.login, required this.home})
      : super(key: key);
  final Widget login;
  final Widget home;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    watch(authState);
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState != ConnectionState.active) {
          return Scaffold();
        } else {
          if (snapshot.hasError) {
            return Scaffold(
                body: Center(child: Text(snapshot.error.toString())));
          } else if (!snapshot.hasData) {
            return login;
          } else if (snapshot.hasData) {
            User? user = snapshot.data;
            if (user != null) {
              return home;
            } else {
              return login;
            }
          } else {
            return Scaffold(
                body: Center(child: Text(snapshot.hashCode.toString())));
          }
        }
      },
    );
  }
}
