import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kizu/core/errors/failure.dart';
import 'package:kizu/features/auth/business/entity/user_entity.dart';
import 'package:kizu/features/auth/business/repository/user_repository.dart';
import 'package:kizu/core/params/user_params.dart';

class RegisterUser {
  final UserRepository userRepository;

  RegisterUser({required this.userRepository});

  Future<Either<Failure, UserEntity>> call(
    UserParams userParams,
    OAuthCredential oAuthCredential,
  ) async {
    return await userRepository.registerUser(user: userParams);
  }
}
