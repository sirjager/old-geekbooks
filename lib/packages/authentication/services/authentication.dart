import 'dart:async';
import 'package:geeklibrary/core/log/log.dart';
import 'package:geeklibrary/packages/authentication/export/export.dart';

class Authentication {
  final FirebaseAuth _auth;
  Authentication(this._auth);

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<AuthResultStatus> signIn(String email, String password) async {
    var _status;
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      _status = AuthResultStatus.successful;
      log.e(_status);
      return _status;
    } on FirebaseAuthException catch (e) {
      _status = AuthExceptionHandler.handleException(e);
      log.e(_status);
      return _status;
    }
  }

  Future<AuthResultStatus> signUp(String email, String password) async {
    var _status;
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _status = AuthResultStatus.successful;
      log.e(_status);
      Future.delayed(Duration(seconds: 2))
          .then((value) => signIn(email, password));
      return _status;
    } on FirebaseAuthException catch (e) {
      _status = AuthExceptionHandler.handleException(e);
      log.e(_status);
      return _status;
    }
  }

  Future<AuthResultStatus> signOut() async {
    var _status;
    try {
      await _auth.signOut();
      _status = AuthResultStatus.successful;
      log.e(_status);
      return _status;
    } on FirebaseAuthException catch (e) {
      _status = AuthExceptionHandler.handleException(e);
      log.e(_status);
      return _status;
    }
  }
}
