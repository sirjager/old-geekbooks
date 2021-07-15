import 'package:geeklibrary/packages/authentication/exception/firestore_excep_handler.dart';
import 'package:geeklibrary/packages/authentication/export/export.dart';

class FirestoreOperations extends FirestoreExceptionHandler {
  //***************************************************************************>  DOES USER DOCUMENT EXIST
  // This return [[ true ]] if user document exists in firestore
  static Future<bool> isNewUser(User user) async {
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
  Future<bool> createNewUser(User user) async {
    final _accountDetails = AccountDetails.build(user);
    bool isMyAccountSaved = await saveAccountDetails(user, _accountDetails);
    return isMyAccountSaved;
  }

  //***************************************************************************>  UPDATE RETURNING USER
  // This return List of [[ true/false ]] if User is updated or not
  Future<bool> updateReturningUser(User user, AccountDetails _account) async {
    final _updatedAccount = _account.copyWith(lastActive: DateTime.now());
    final updatedUser = await saveAccountDetails(user, _updatedAccount);
    return updatedUser;
  }

  //?==========================================================================> Saving Account Details
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
      print("\nAccount Details Model saved\n");
      return status;
    } else {
      print("\nAccount Details Model not saved\n");
      return status;
    }
  }

  static Future<AccountDetails> getAccountDetails(User user) async {
    DocumentSnapshot collected = await FirebaseFirestore.instance
        .collection(AuthStr.geeklibrary)
        .doc(user.uid)
        .get()
        // ignore: invalid_return_type_for_catch_error
        .catchError((e) => FirestoreExceptionHandler.handleException(e));
    return Generate().personFromSnapshot(collected);
  }
}
