import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';

Person memberFromMap(String str) => Person.fromMap(json.decode(str));
String memberToMap(Person data) => json.encode(data.toMap());

class Person {
  Person({
    required this.uid,
    this.name,
    this.email,
    this.image,
    this.phone,
    required this.isVerified,
    this.lastActive,
    required this.isAnonymous,
  });

  final String uid;
  final String? name;
  final String? image;
  final String? email;
  final String? phone;
  final DateTime? lastActive;
  final bool isVerified;
  final bool isAnonymous;

  factory Person.fromMap(Map<String, dynamic> json) => Person(
        uid: json["uid"],
        image: json["image"],
        email: json["email"].toString().toLowerCase(),
        name: json["name"],
        phone: json["phone"],
        isVerified: json["isVerified"],
        lastActive: json["lastActive"],
        isAnonymous: json["isAnonymous"],
      );

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "name": name,
        "image": image,
        "phone": phone,
        "email": email.toString().toLowerCase(),
        "lastActive": DateTime.now(),
        "isVerified": isVerified,
        "isAnonymous": isAnonymous,
      };
}

class AccountDetails {
  AccountDetails({
    required this.uid,
    required this.email,
    required this.isVerified,
    required this.lastActive,
    required this.isAnonymous,
    required this.isAccountEnabled,
  });

  final String uid;
  final String email;
  final bool isVerified;
  final bool isAnonymous;
  final bool isAccountEnabled;
  final DateTime lastActive;
  factory AccountDetails.build(User user) => AccountDetails(
        uid: user.uid,
        email: user.email!,
        lastActive: DateTime.now(),
        isVerified: user.emailVerified,
        isAnonymous: user.isAnonymous,
        isAccountEnabled: true,
      );

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "email": email.toString().toLowerCase(),
        "isVerified": isVerified,
        'lastActive': lastActive,
        "isAnonymous": isAnonymous,
        "isAccountEnabled": isAccountEnabled,
      };
}

class PersistUser {
  PersistUser({
    this.uid,
    this.email,
    this.lastActive,
  });

  final String? uid;
  final String? email;
  final DateTime? lastActive;
  factory PersistUser.build(User user) => PersistUser(
        uid: user.uid,
        email: user.email,
        lastActive: DateTime.now(),
      );

  Map<String, dynamic> toMap() =>
      {"uid": uid, "email": email, 'lastActive': lastActive};
}
