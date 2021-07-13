import 'package:flutter/material.dart';
import 'package:geekbooks/bundles/authentication/export/export.dart';
import 'package:geekbooks/core/log/log.dart';

class Authentication extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //! private
  String? _eImail = "";
  AuthResultStatus _status = AuthResultStatus.undefined;
  //* public
  AuthResultStatus get authStatus => _status;
  String? get email => _eImail;

  Stream<User?> get authStateChanges => _auth.idTokenChanges();

  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential _credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? _oOser = _credential.user;
      if (_oOser != null) {
        _eImail = _oOser.email;
        log.e("\n\n$_status\n\n");
        return AuthResultStatus.successful;
      } else
        _eImail = null;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      _status = AuthExceptionHandler.handleException(e);
      log.e("\n\n$_status\n\n");
      return _status;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential _credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? _oOser = _credential.user;
      if (_oOser != null) {
        _eImail = _oOser.email;
        log.e("\n\n$_status\n\n");
        return AuthResultStatus.successful;
      } else
        _eImail = null;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      _status = AuthExceptionHandler.handleException(e);
      log.e("\n\n$_status\n\n");
      return _status;
    }
  }
}
