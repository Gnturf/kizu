import 'package:firebase_auth/firebase_auth.dart';

class UserParams {
  UserCredential? userCredential;
  OAuthCredential? oAuthCredential;
  String? displayName;
  String? password;

  UserParams({
    this.userCredential,
    this.oAuthCredential,
    this.displayName,
    this.password,
  });
}
