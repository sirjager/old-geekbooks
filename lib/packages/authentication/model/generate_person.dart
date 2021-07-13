import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geekbooks/packages/authentication/model/person_model.dart';

class Generate {
  //! Pass user to generate Person Object
  Person personFromUser(User user) {
    return new Person(
      uid: user.uid,
      name: user.displayName,
      image: user.photoURL,
      email: user.email,
      phone: user.phoneNumber,
      isVerified: user.emailVerified,
      isAnonymous: user.isAnonymous,
      lastActive: DateTime.now(),
    );
  }

  //! Pass user to generate Person Object
  Person publicFromUser(User user) {
    return new Person(
      uid: user.uid,
      email: user.email,
      isAnonymous: user.isAnonymous,
      isVerified: user.emailVerified,
    );
  }

//! Pass user's document snapshot to generate Person Object
  Person personFromSnapshot(DocumentSnapshot snapshot) {
    return Person(
      uid: snapshot['uid'],
      name: snapshot["name"],
      image: snapshot["image"],
      email: snapshot["email"],
      phone: snapshot["phone"],
      isVerified: snapshot["isVerified"],
      lastActive: (snapshot["lastActive"] as Timestamp).toDate(),
      isAnonymous: snapshot["isAnonymous"],
    );
  }
}
