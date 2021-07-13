import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geekbooks/packages/authentication/constants/constants.dart';
import 'package:geekbooks/packages/authentication/model/generate_person.dart';
import 'package:geekbooks/packages/authentication/model/person_model.dart';
import 'package:geekbooks/packages/authentication/model/settings_model.dart';

class AuthenticationFunctions {
  Person _person = Person();
  MyUser _myuser = MyUser();
  PersistUser _persist = PersistUser();
  MySettings _settings = MySettings();
  Generate _generate = Generate();
//*****************************************************************************>  CREATE NEW USER
  Future<bool> createNewUser({required User user}) async {
    _myuser = MyUser.build(user);
    _settings = MySettings(isDarkMode: false);
    _person = _generate.personFromUser(user);
    _persist = PersistUser.build(user);

    //!============================================================================> Storing Default Theme
    await FirebaseFirestore.instance
        .collection(AuthStr.geekbooks)
        .doc(user.uid)
        .collection(AuthStr.preferences)
        .doc(AuthStr.appState)
        .set(_settings.toMap(), SetOptions(merge: true))
        .then((value) => true);

    //!============================================================================> STORING Public MyUser MODEL
    await FirebaseFirestore.instance
        .collection(AuthStr.geekbooks)
        .doc(user.uid)
        .set(_myuser.toMap(), SetOptions(merge: true))
        .then((value) => true);
    //!============================================================================> STORING PERSON MODEL
    bool isCreated = await FirebaseFirestore.instance
        .collection(AuthStr.geekbooks)
        .doc(user.uid)
        .collection(AuthStr.person)
        .doc(AuthStr.details)
        .set(_person.toMap(), SetOptions(merge: true))
        .then((value) => true);
    return isCreated;
  }

//*****************************************************************************>  UPDATE RETURNING USER
  Future<bool> updateReturningUser({required User user}) async {
    _persist = PersistUser(
        uid: user.uid, email: user.email, lastActive: DateTime.now());
    //!============================================================================> STORING USER'S UID,EMAIL,ROLE EVERYTIME TO KEEP PERSIST
    bool isUpdated = await FirebaseFirestore.instance
        .collection(AuthStr.geekbooks)
        .doc(user.uid)
        .collection(AuthStr.person)
        .doc(AuthStr.details)
        .set(_persist.toMap(), SetOptions(merge: true))
        .then((value) => true);
    return isUpdated;
  }

//?================== Member Object Generated from Snapshot=====================
//
  Future<Person> getUserDetails(String uid) async {
    DocumentSnapshot collected = await FirebaseFirestore.instance
        .collection(AuthStr.geekbooks)
        .doc(uid)
        .collection(AuthStr.person)
        .doc(AuthStr.details)
        .get();
    return _generate.personFromSnapshot(collected);
  }

//?=============== MySettings Object Generated from Snapshot==================
//
  Future<MySettings> getAppSettings(String uid) async {
    DocumentSnapshot _settings = await FirebaseFirestore.instance
        .collection(AuthStr.geekbooks)
        .doc(uid)
        .collection(AuthStr.preferences)
        .doc(AuthStr.appState)
        .get();
    return _appSettings(_settings);
  }

  //?========== Returns True After uploading Updated User Settings================
//
  Future<bool> updateUserPrefs(String uid, bool value) async {
    MySettings _settings = MySettings(isDarkMode: value);
    await FirebaseFirestore.instance
        .collection(AuthStr.geekbooks)
        .doc(uid)
        .collection(AuthStr.preferences)
        .doc(AuthStr.appState)
        .set(_settings.toMap(), SetOptions(merge: true));
    return true;
  }

  //?================ MySettings OBJECT GENERATED FROM SNAPSHOT =====================
  MySettings _appSettings(DocumentSnapshot snapshot) {
    return MySettings(isDarkMode: snapshot["isDarkMode"]);
  }

//?=========== Stream Of Appsettings Object Generated from Snapshot=============
//
  Stream<MySettings> streamAppSettings(String uid) {
    return FirebaseFirestore.instance
        .collection(AuthStr.geekbooks)
        .doc(uid)
        .collection(AuthStr.preferences)
        .doc(AuthStr.appState)
        .snapshots()
        .map(_appSettings);
  }
}
