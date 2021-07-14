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
    final _state = watch(authState);
    return _state.when(
      data: (user) => user == null ? login : home,
      loading: () => Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (v, e) => Scaffold(body: Center(child: Text(e.toString()))),
    );
  }
}
