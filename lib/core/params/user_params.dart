import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';

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
