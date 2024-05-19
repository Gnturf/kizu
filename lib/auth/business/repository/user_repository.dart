import 'package:firebase_auth/firebase_auth.dart';
import 'package:kizu/auth/business/entity/user_entity.dart';
import 'package:kizu/auth/data/models/user_params.dart';

abstract class UserRepository {
  Future<OAuthCredential> creatingOAuthCredential();
  Future<UserEntity> registerUser(
      {required UserParams user, required OAuthCredential oAuthCredential});
  Future<void> cleanSession();
}
