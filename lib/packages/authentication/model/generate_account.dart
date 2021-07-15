import 'package:geeklibrary/packages/authentication/export/export.dart';

class Generate {
  //! Pass user to generate Person Object
  AccountDetails personFromUser(User user) {
    return new AccountDetails(
      uid: user.uid,
      name: user.displayName,
      image: user.photoURL,
      email: user.email,
      isAccountEnabled: true,
      isVerified: user.emailVerified,
      isDarkThemeEnabled: false,
      isAnonymous: user.isAnonymous,
      lastActive: DateTime.now(),
      accountStatus: "Healthy",
    );
  }

//! Pass user's document snapshot to generate AccountDetails Object
  AccountDetails personFromSnapshot(DocumentSnapshot snapshot) {
    return AccountDetails(
      uid: snapshot['uid'],
      name: snapshot["name"],
      image: snapshot["image"],
      email: snapshot["email"],
      isVerified: snapshot["isVerified"],
      lastActive: (snapshot["lastActive"] as Timestamp).toDate(),
      isAnonymous: snapshot["isAnonymous"],
      isAccountEnabled: snapshot["isAccountEnabled"],
      isDarkThemeEnabled: snapshot["isDarkThemeEnabled"],
      accountStatus: snapshot["accountStatus"],
    );
  }
}
