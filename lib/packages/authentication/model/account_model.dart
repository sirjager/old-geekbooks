import 'package:firebase_auth/firebase_auth.dart';

class AccountDetails {
  AccountDetails({
    required this.uid,
    required this.email,
    required this.name,
    required this.image,
    required this.isVerified,
    required this.lastActive,
    required this.isAnonymous,
    required this.isAccountEnabled,
    required this.isDarkThemeEnabled,
    required this.accountStatus,
  });

  final String uid;
  final String? name;
  final String? image;
  final String? email;
  final bool isVerified;
  final bool isAnonymous;
  final bool isAccountEnabled;
  final DateTime lastActive;
  final bool isDarkThemeEnabled;
  final String accountStatus;

  factory AccountDetails.build(User user) => AccountDetails(
        uid: user.uid,
        email: user.email!,
        name: user.displayName,
        image: user.photoURL,
        isAccountEnabled: true,
        accountStatus: "Healthy",
        isDarkThemeEnabled: false,
        lastActive: DateTime.now(),
        isVerified: user.emailVerified,
        isAnonymous: user.isAnonymous,
      );

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "name": name,
        "image": image,
        "isVerified": isVerified,
        'lastActive': lastActive,
        "isAnonymous": isAnonymous,
        "accountStatus": accountStatus,
        "isAccountEnabled": isAccountEnabled,
        "email": email.toString().toLowerCase(),
        "isDarkThemeEnabled": isDarkThemeEnabled,
      };

  AccountDetails copyWith({
    String? accountStatus,
    String? email,
    bool? isAccountEnabled,
    bool? isAnonymous,
    bool? isDarkThemeEnabled,
    bool? isVerified,
    DateTime? lastActive,
    String? uid,
    String? image,
    String? name,
  }) =>
      AccountDetails(
        uid: uid ?? this.uid,
        name: name ?? this.name,
        image: image ?? this.image,
        email: email ?? this.email,
        lastActive: lastActive ?? this.lastActive,
        isVerified: isVerified ?? this.isVerified,
        isAnonymous: isAnonymous ?? this.isAnonymous,
        accountStatus: accountStatus ?? this.accountStatus,
        isAccountEnabled: isAccountEnabled ?? this.isAccountEnabled,
        isDarkThemeEnabled: isDarkThemeEnabled ?? this.isDarkThemeEnabled,
      );
}
