import 'package:firebase_auth/firebase_auth.dart';
import 'package:geeklibrary/packages/authentication/export/export.dart';

class AccountDetails {
  AccountDetails({
    required this.uid,
    required this.email,
    required this.name,
    required this.isVerified,
    required this.creationTime,
    required this.isAccountEnabled,
    required this.isDarkThemeEnabled,
    required this.accountStatus,
  });

  final String uid;
  final String? name;

  final String? email;
  final bool isVerified;
  final bool isAccountEnabled;
  final String? creationTime;
  final bool isDarkThemeEnabled;
  final String accountStatus;

  factory AccountDetails.build(User user) => AccountDetails(
        uid: user.uid,
        email: user.email!,
        name: user.displayName ?? "",
        isAccountEnabled: true,
        accountStatus: "Healthy",
        isDarkThemeEnabled: false,
        creationTime: user.metadata.creationTime.toString(),
        isVerified: user.emailVerified,
      );

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "name": name,
        "isVerified": isVerified,
        'creationTime': creationTime.toString(),
        "accountStatus": accountStatus,
        "isAccountEnabled": isAccountEnabled,
        "email": email.toString().toLowerCase(),
        "isDarkThemeEnabled": isDarkThemeEnabled,
      };

  AccountDetails copyWith({
    String? accountStatus,
    String? email,
    bool? isAccountEnabled,
    bool? isDarkThemeEnabled,
    bool? isVerified,
    String? creationTime,
    String? uid,
    String? image,
    String? name,
  }) =>
      AccountDetails(
        uid: uid ?? this.uid,
        name: name ?? this.name,
        email: email ?? this.email,
        creationTime: creationTime ?? this.creationTime,
        isVerified: isVerified ?? this.isVerified,
        accountStatus: accountStatus ?? this.accountStatus,
        isAccountEnabled: isAccountEnabled ?? this.isAccountEnabled,
        isDarkThemeEnabled: isDarkThemeEnabled ?? this.isDarkThemeEnabled,
      );
}
