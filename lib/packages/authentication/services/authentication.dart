import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:geekbooks/packages/authentication/constants/constants.dart';
import 'package:geekbooks/packages/authentication/functions/authentication_fnx.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
  final FirebaseAuth _auth;
  final Widget? home;
  final Widget? login;
  Authentication(this._auth, {this.login, this.home});
  Stream<User?> get authStateChanges => _auth.idTokenChanges();

  AuthenticationFunctions _userCall = AuthenticationFunctions();

  final CollectionReference usersCRF =
      FirebaseFirestore.instance.collection(AuthStr.geekbooks);

  Future<User?> getCurrentUser() async {
    User? currentUser = _auth.currentUser;
    return currentUser;
  }

  //!TODO======================================================================> GOOGLE SIGNIN METHOD
  Future<bool> signInWithGoogle() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleSignInAccount =
        await _googleSignIn.signIn() as GoogleSignInAccount;
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    UserCredential result = await _auth.signInWithCredential(credential);
    User? user = result.user;
    if (user == null) return false;
    bool isUserCheckComplete = await checkUser(user);
    print("user has been checked  ✅");
    return isUserCheckComplete;
  }

  //!todo======================================================================> SIGN OUT METHOD

  Future<bool> signOut() async {
    try {
      final GoogleSignIn _googleSignOut = GoogleSignIn();
      await _auth.signOut();
      bool isSignedOut =
          await _googleSignOut.disconnect().then((value) => true);
      // Get.offAll(() => AuthenticationWrapper(login: login!, home: home!));
      print(isSignedOut
          ? "User has been signed out sucessfully"
          : "Signing out was unsucessful");
      return isSignedOut;
    } catch (e) {
      bool isSignedOut = false;
      print("\n$e\n");
      return isSignedOut;
    }
  }

  Future<bool> checkUser(User user) async {
    QuerySnapshot result =
        await usersCRF.where("uid", isEqualTo: user.uid).get();
    final List<DocumentSnapshot> docSnap = result.docs;
    final bool isNewUser = docSnap.length == 0 ? true : false;
    if (isNewUser) {
      await _userCall.createNewUser(user: user);
      return true;
    } else {
      await _userCall.updateReturningUser(user: user);
      return true;
    }
  }
}
