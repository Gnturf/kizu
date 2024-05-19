import 'package:firebase_auth/firebase_auth.dart';

class UserParams {
  final OAuthCredential oAuthCredential;
  String? displayName;
  String? password;

  UserParams({
    required this.oAuthCredential,
    this.displayName,
    this.password,
  });
}
