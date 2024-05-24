import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kizu/core/errors/failure.dart';
import 'package:kizu/core/params/user_params.dart';
import 'package:kizu/features/auth/business/entity/user_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, OAuthCredential>> createOAuthCredential();
  Future<Either<Failure, UserCredential>> registerToFirebase({
    required OAuthCredential oAuthCredential,
  });
  Future<Either<Failure, UserEntity>> registerToRemote({
    required UserParams userParams,
  });
  Future<void> cleanSession();
  Future<Either<Failure, bool>> isUserAlreadyExist();
  Future<Either<Failure, void>> cachedUser(UserEntity userEntity);
  Future<Either<Failure, UserEntity>> fetchUser();
  Future<Either<Failure, void>> signOut();
}
