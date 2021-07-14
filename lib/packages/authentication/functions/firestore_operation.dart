import 'package:geeklibrary/packages/authentication/exception/firestore_excep_handler.dart';
import 'package:geeklibrary/packages/authentication/export/export.dart';

class FireStoreOperations extends FirestoreExceptionHandler {
  Future<bool> userExist(User user) async {
    QuerySnapshot result = await FirebaseFirestore.instance
        .collection(AuthStr.geeklibrary)
        .where("uid", isEqualTo: user.uid)
        .get()
        .catchError((e) => FirestoreExceptionHandler.handleException(e));
    final List<DocumentSnapshot> docSnap = result.docs;
    final bool isNewUser = docSnap.length == 0 ? true : false;
    return isNewUser;
  }
}
