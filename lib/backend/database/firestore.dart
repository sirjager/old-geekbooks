import 'package:geeklibrary/packages/authentication/exception/firestore_excep_handler.dart';
import 'package:geeklibrary/packages/authentication/export/export.dart';

class BackEndOperation {
  //***************************************************************************>  UPDATE RETURNING USER

  //?==========================================================================> Saving Account Details
  static Future<bool> updateUser(String field, value) async {
    final User user = FirebaseAuth.instance.currentUser!;
    var status = await FirebaseFirestore.instance
        .collection(AuthStr.geeklibrary)
        .doc(user.uid)
        .set({field: value}, SetOptions(merge: true))
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
}
