import 'package:geeklibrary/packages/authentication/export/export.dart';

class FirestoreGetOperations {
//?================== Member Object Generated from Snapshot=====================
//
  static Future<Person> getPerson(User user) async {
    DocumentSnapshot collected = await FirebaseFirestore.instance
        .collection(AuthStr.geeklibrary)
        .doc(user.uid)
        .collection(AuthStr.person)
        .doc(AuthStr.details)
        .get();
    return Generate().personFromSnapshot(collected);
  }

//?================== Member Object Generated from Snapshot=====================
//
  static Future<AccountDetails> getAccountDetails(User user) async {
    DocumentSnapshot collected = await FirebaseFirestore.instance
        .collection(AuthStr.geeklibrary)
        .doc(user.uid)
        .get();
    return Generate().myAccountDetailsFromSnapshot(collected);
  }

//?=============== MySettings Object Generated from Snapshot==================
//
  static Future<MySettings> getAppSettings(User user) async {
    DocumentSnapshot _settings = await FirebaseFirestore.instance
        .collection(AuthStr.geeklibrary)
        .doc(user.uid)
        .collection(AuthStr.preferences)
        .doc(AuthStr.appState)
        .get();
    return _appSettings(_settings);
  }

  //?========== Returns True After uploading Updated User Settings================
//
  static Future<bool> updateUserPrefs(String uid, bool value) async {
    MySettings _settings = MySettings(isDarkMode: value);
    await FirebaseFirestore.instance
        .collection(AuthStr.geeklibrary)
        .doc(uid)
        .collection(AuthStr.preferences)
        .doc(AuthStr.appState)
        .set(_settings.toMap(), SetOptions(merge: true));
    return true;
  }

  //?================ MySettings OBJECT GENERATED FROM SNAPSHOT =====================
  static MySettings _appSettings(DocumentSnapshot snapshot) {
    return MySettings(isDarkMode: snapshot["isDarkMode"]);
  }

//?=========== Stream Of Appsettings Object Generated from Snapshot=============
//
  Stream<MySettings> streamAppSettings(String uid) {
    return FirebaseFirestore.instance
        .collection(AuthStr.geeklibrary)
        .doc(uid)
        .collection(AuthStr.preferences)
        .doc(AuthStr.appState)
        .snapshots()
        .map(_appSettings);
  }
}
