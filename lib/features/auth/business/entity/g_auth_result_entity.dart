import 'package:firebase_auth/firebase_auth.dart';

class GAuthResultEntity {
  UserCredential userCredential;
  bool isNew;

  GAuthResultEntity({
    required this.userCredential,
    required this.isNew,
  });
}
