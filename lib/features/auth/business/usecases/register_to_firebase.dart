import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kizu/core/errors/failure.dart';
import 'package:kizu/features/auth/business/repository/user_repository.dart';

class RegisterUserToFirebase {
  final UserRepository userRepository;

  RegisterUserToFirebase({required this.userRepository});

  Future<Either<Failure, UserCredential>> call() async {
    return await userRepository.registerToFirebase();
  }
}
