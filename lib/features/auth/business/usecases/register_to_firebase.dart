import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kizu/core/errors/failure.dart';
import 'package:kizu/features/auth/business/repository/auth_repository.dart';

class RegisterToFirebase {
  AuthRepository repository;

  RegisterToFirebase({required this.repository});

  Future<Either<Failure, UserCredential>> call(
      OAuthCredential oAuthCredential) async {
    return await repository.registerToFirebase(
      oAuthCredential: oAuthCredential,
    );
  }
}
