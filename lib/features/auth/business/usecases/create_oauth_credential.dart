import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kizu/core/errors/failure.dart';
import 'package:kizu/features/auth/business/repository/auth_repository.dart';

class CreateOAuthCredential {
  AuthRepository repository;

  CreateOAuthCredential({required this.repository});

  Future<Either<Failure, OAuthCredential>> call() async {
    return await repository.createOAuthCredential();
  }
}
