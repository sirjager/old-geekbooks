import 'dart:async';
import 'package:geeklibrary/core/log/log.dart';
import 'package:geeklibrary/packages/authentication/export/export.dart';

class Authentication {
  final FirebaseAuth _auth;
  Authentication(this._auth);

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<bool> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      log.e("Method = Signin\nEmail = $email\nStatus = Sucessfull");
      return true;
    } on FirebaseAuthException catch (e) {
      AuthExceptionHandler.handleException(e);
      return false;
    }
  }

  Future<bool> signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      log.e("Method = SignUp\nEmail = $email\nStatus = Sucessfull");
      return true;
    } on FirebaseAuthException catch (e) {
      AuthExceptionHandler.handleException(e);
      return false;
    }
  }

  Future<bool> signOut() async {
    try {
      await _auth.signOut();
      return true;
    } on FirebaseAuthException catch (e) {
      AuthExceptionHandler.handleException(e);
      return false;
    }
  }
}
