import 'dart:convert';

class UserEntity {
  final String? uid;
  final String? displayName;
  final String? email;
  bool emailVerified;
  final bool isAnonymous;
  final String? phoneNumber;
  final String? photoURL;
  String? accessToken;
  final String? refreshToken;
  final String? tenantId;
  UserEntity({
    this.uid,
    this.displayName,
    this.email,
    this.emailVerified = true,
    this.isAnonymous = false,
    this.phoneNumber,
    this.photoURL,
    this.accessToken,
    this.refreshToken,
    this.tenantId,
  });
  Map get toMap => {
        "uid": uid,
        "displayName": displayName,
        "email": email,
        "emailVerified": emailVerified,
        "isAnonymous": isAnonymous,
        "phoneNumber": phoneNumber,
        "photoURL": photoURL,
        "accessToken": accessToken,
        "refreshToken": refreshToken,
        "tenantId": tenantId,
      };

  @override
  String toString() => jsonEncode(toMap);
}
