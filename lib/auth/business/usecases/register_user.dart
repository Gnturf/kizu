import 'package:firebase_auth/firebase_auth.dart';
import 'package:kizu/auth/business/entity/user_entity.dart';
import 'package:kizu/auth/business/repository/user_repository.dart';
import 'package:kizu/auth/data/models/user_params.dart';

class RegisterUser {
  final UserRepository userRepository;

  RegisterUser({required this.userRepository});

  Future<UserEntity> call(
    UserParams userParams,
    OAuthCredential oAuthCredential,
  ) async {
    return await userRepository.registerUser(
        user: userParams, oAuthCredential: oAuthCredential);
  }
}
