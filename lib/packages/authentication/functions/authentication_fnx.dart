import 'package:geeklibrary/packages/authentication/export/export.dart';

class UserOption {
  Person _person = Person();
  MyUser _myuser = MyUser();
  PersistUser _persist = PersistUser();
  MySettings _settings = MySettings();
  Generate _generate = Generate();

  Future<bool> checkUser(User user) async {
    QuerySnapshot result = await FirebaseFirestore.instance
        .collection(AuthStr.geeklibrary)
        .where("uid", isEqualTo: user.uid)
        .get();
    final List<DocumentSnapshot> docSnap = result.docs;
    final bool isNewUser = docSnap.length == 0 ? true : false;
    if (isNewUser) {
      await createNewUser(user: user);
      return true;
    } else {
      await updateReturningUser(user: user);
      return true;
    }
  }

//*****************************************************************************>  CREATE NEW USER
  Future<bool> createNewUser({required User user}) async {
    _myuser = MyUser.build(user);
    _settings = MySettings(isDarkMode: false);
    _person = _generate.personFromUser(user);
    _persist = PersistUser.build(user);
    //!============================================================================> Storing Default Theme
    await FirebaseFirestore.instance
        .collection(AuthStr.geeklibrary)
        .doc(user.uid)
        .collection(AuthStr.preferences)
        .doc(AuthStr.appState)
        .set(_settings.toMap(), SetOptions(merge: true))
        .then((value) => print("\nStored Default Theme for new user \n"));
    //!============================================================================> STORING Public MyUser MODEL
    await FirebaseFirestore.instance
        .collection(AuthStr.geeklibrary)
        .doc(user.uid)
        .set(_myuser.toMap(), SetOptions(merge: true))
        .then((value) => print("\nStored MyUser model for new user \n"));
    //!============================================================================> STORING PERSON MODEL
    bool isCreated = await FirebaseFirestore.instance
        .collection(AuthStr.geeklibrary)
        .doc(user.uid)
        .collection(AuthStr.person)
        .doc(AuthStr.details)
        .set(_person.toMap(), SetOptions(merge: true))
        .then((value) => true);
    print("\nStored Person Model for new user !\n");
    return isCreated;
  }

//*****************************************************************************>  UPDATE RETURNING USER
  Future<bool> updateReturningUser({required User user}) async {
    _persist = PersistUser(
        uid: user.uid, email: user.email, lastActive: DateTime.now());
    //!============================================================================> STORING USER'S UID,EMAIL,ROLE EVERYTIME TO KEEP PERSIST
    bool isUpdated = await FirebaseFirestore.instance
        .collection(AuthStr.geeklibrary)
        .doc(user.uid)
        .collection(AuthStr.person)
        .doc(AuthStr.details)
        .set(_persist.toMap(), SetOptions(merge: true))
        .then((value) => true);
    print("\nUpdated Returning User \n");
    return isUpdated;
  }

//?================== Member Object Generated from Snapshot=====================
//
  Future<Person> getUserDetails(String uid) async {
    DocumentSnapshot collected = await FirebaseFirestore.instance
        .collection(AuthStr.geeklibrary)
        .doc(uid)
        .collection(AuthStr.person)
        .doc(AuthStr.details)
        .get();
    return _generate.personFromSnapshot(collected);
  }

//?================== Member Object Generated from Snapshot=====================
//
  Future<MyUser> getAccountDetails(String uid) async {
    DocumentSnapshot collected = await FirebaseFirestore.instance
        .collection(AuthStr.geeklibrary)
        .doc(uid)
        .get();
    return _generate.myUserFromSnapshot(collected);
  }

//?=============== MySettings Object Generated from Snapshot==================
//
  Future<MySettings> getAppSettings(String uid) async {
    DocumentSnapshot _settings = await FirebaseFirestore.instance
        .collection(AuthStr.geeklibrary)
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
        .collection(AuthStr.geeklibrary)
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
        .collection(AuthStr.geeklibrary)
        .doc(uid)
        .collection(AuthStr.preferences)
        .doc(AuthStr.appState)
        .snapshots()
        .map(_appSettings);
  }
}
