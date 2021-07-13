import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:geekbooks/packages/authentication/exception/exceptions.dart';

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
        return AuthResultStatus.successful;
      } else
        _eImail = null;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      _status = AuthExceptionHandler.handleException(e);
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
        return AuthResultStatus.successful;
      } else
        _eImail = null;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      _status = AuthExceptionHandler.handleException(e);
      return _status;
    }
  }
}
