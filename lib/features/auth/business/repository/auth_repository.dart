import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kizu/core/errors/failure.dart';
import 'package:kizu/core/params/user_params.dart';

abstract class AuthRepository {
  Future<Either<Failure, OAuthCredential>> createOAuthCredential();
  Future<Either<Failure, UserCredential>> registerToFirebase({
    required OAuthCredential oAuthCredential,
  });
  Future<Either<Failure, void>> registerToRemote({
    required UserParams userParams,
  });
  Future<void> cleanSession();
  Future<Either<Failure, bool>> isUserAlreadyExist();
}
