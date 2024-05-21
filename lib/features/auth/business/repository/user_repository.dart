import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kizu/core/errors/failure.dart';
import 'package:kizu/features/auth/business/entity/user_entity.dart';
import 'package:kizu/features/auth/data/models/user_model.dart';
import 'package:kizu/core/params/user_params.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> registerUser({required UserParams user});
  Future<Either<Failure, UserEntity>> getUser();
  Future<Either<Failure, void>> signOutUser();
  Future<Either<Failure, void>> cachedUser(UserModel userModel);
  Future<Either<Failure, UserCredential>> registerToFirebase();
  Future<void> cleanSession();
}
