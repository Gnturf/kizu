import 'package:firebase_auth/firebase_auth.dart';
import 'package:kizu/auth/business/entity/user_entity.dart';
import 'package:kizu/auth/data/models/user_params.dart';

abstract class UserRepository {
  Future<UserEntity> registerUser({required UserParams user});
  Future<void> signOutUser();
  Future<OAuthCredential> creatingOAuthCredential();
  Future<void> cleanSession();
}
