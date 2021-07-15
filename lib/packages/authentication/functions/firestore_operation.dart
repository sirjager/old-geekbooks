import 'package:geeklibrary/packages/authentication/exception/firestore_excep_handler.dart';
import 'package:geeklibrary/packages/authentication/export/export.dart';

class FirestoreOperations extends FirestoreExceptionHandler {
  //***************************************************************************>  DOES USER DOCUMENT EXIST
  // This return [[ true ]] if user document exists in firestore
  static Future<bool> userExist(User user) async {
    QuerySnapshot result = await FirebaseFirestore.instance
        .collection(AuthStr.geeklibrary)
        .where("uid", isEqualTo: user.uid)
        .get()
        // ignore: invalid_return_type_for_catch_error
        .catchError((e) => FirestoreExceptionHandler.handleException(e));
    final List<DocumentSnapshot> docSnap = result.docs;
    final bool isNewUser = docSnap.length == 0 ? true : false;
    return isNewUser;
  }

  //***************************************************************************>  CREATE NEW USER
  // This return List of [[ boolean values ]] if for Given Operations
  Future<List<bool>> createNewUser(User user) async {
    final _accountDetails = AccountDetails.build(user);
    final _settings = MySettings(isDarkMode: false);
    final _person = Generate().personFromUser(user);
    //!========================================================================> Storing AccountDetails Model
    bool isMyUserSaved = await saveAccountDetails(user, _accountDetails);
    //!========================================================================> Storing Default Theme
    bool isAppsettingsSaved = await saveAppSetting(user, _settings);
    //!========================================================================> Storing Person Model
    bool isPersonSaved = await savePerson(user, _person);
    return [isMyUserSaved, isAppsettingsSaved, isPersonSaved];
  }

  //***************************************************************************>  UPDATE RETURNING USER
  // This return List of [[ true/false ]] if User is updated or not
  Future<bool> updateReturningUser(User user) async {
    final _accountDetails = AccountDetails.build(user);
    final updatedUser = await saveAccountDetails(user, _accountDetails);
    return updatedUser;
  }

  static Future<bool> saveAppSetting(User user, MySettings _settings) async {
    var status = await FirebaseFirestore.instance
        .collection(AuthStr.geeklibrary)
        .doc(user.uid)
        .collection(AuthStr.preferences)
        .doc(AuthStr.appState)
        .set(_settings.toMap(), SetOptions(merge: true))
        .then((value) => true)
        // ignore: invalid_return_type_for_catch_error
        .catchError((e) => FirestoreExceptionHandler.handleException(e));
    if (status) {
      print("\nAppSettings saved\n");
      return true;
    } else {
      print("\nAppSettings not saved\n");
      return false;
    }
  }

  static Future<bool> saveAccountDetails(
      User user, AccountDetails _accountDetails) async {
    var status = await FirebaseFirestore.instance
        .collection(AuthStr.geeklibrary)
        .doc(user.uid)
        .set(_accountDetails.toMap(), SetOptions(merge: true))
        .then((value) => true)
        // ignore: invalid_return_type_for_catch_error
        .catchError((e) => FirestoreExceptionHandler.handleException(e));
    if (status) {
      print("\nMyUser Model saved\n");
      return true;
    } else {
      print("\nMyUser Model not saved\n");
      return false;
    }
  }

  static Future<bool> savePerson(User user, Person _person) async {
    var status = await FirebaseFirestore.instance
        .collection(AuthStr.geeklibrary)
        .doc(user.uid)
        .collection(AuthStr.person)
        .doc(AuthStr.details)
        .set(_person.toMap(), SetOptions(merge: true))
        .then((value) => true)
        // ignore: invalid_return_type_for_catch_error
        .catchError((e) => FirestoreExceptionHandler.handleException(e));
    if (status) {
      print("\nPerson Model is saved\n");
      return true;
    } else {
      print("\nPerson Model not saved\n");
      return false;
    }
  }
}
