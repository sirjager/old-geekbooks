import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geeklibrary/packages/authentication/export/export.dart';

class Generate {
  //! Pass user to generate Person Object
  AccountDetails personFromUser(User user) {
    return new AccountDetails(
      uid: user.uid,
      name: user.displayName,
      email: user.email,
      isAccountEnabled: true,
      isVerified: user.emailVerified,
      isDarkThemeEnabled: false,
      creationTime: user.metadata.creationTime.toString(),
      accountStatus: "Healthy",
    );
  }

//! Pass user's document snapshot to generate AccountDetails Object
  AccountDetails personFromSnapshot(DocumentSnapshot snapshot) {
    return AccountDetails(
      uid: snapshot['uid'],
      name: snapshot["name"],
      email: snapshot["email"],
      isVerified: snapshot["isVerified"],
      creationTime: snapshot["creationTime"].toString(),
      isAccountEnabled: snapshot["isAccountEnabled"],
      isDarkThemeEnabled: snapshot["isDarkThemeEnabled"],
      accountStatus: snapshot["accountStatus"],
    );
  }
}
