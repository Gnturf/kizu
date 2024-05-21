import 'package:firebase_auth/firebase_auth.dart';

class UserParams {
  final UserCredential userCredential;
  String? displayName;
  String? password;

  UserParams({
    required this.userCredential,
    this.displayName,
    this.password,
  });
}
