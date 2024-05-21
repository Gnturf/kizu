import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kizu/core/errors/exception.dart';
import 'package:kizu/core/errors/failure.dart';
import 'package:kizu/features/auth/business/entity/user_entity.dart';
import 'package:kizu/features/auth/data/datasources/firebase_data_source.dart';
import 'package:kizu/features/auth/business/repository/user_repository.dart';
import 'package:kizu/features/auth/data/datasources/local_data_source.dart';
import 'package:kizu/features/auth/data/models/user_model.dart';
import 'package:kizu/core/params/user_params.dart';

class UserRepositoryImpl extends UserRepository {
  final FirebaseDataSource firebaseDataSource;
  final UserLocalDataSources userLocalDataSources;

  UserRepositoryImpl({
    required this.firebaseDataSource,
    required this.userLocalDataSources,
  });

  // Regiter User
  @override
  Future<Either<Failure, UserEntity>> registerUser({
    required UserParams user,
  }) async {
    try {
      if (user.userCredential.user != null) {
        final UserModel userModel = UserModel(
          uid: user.userCredential.user!.uid,
          displayName: user.displayName!,
          email: user.userCredential.user!.email!,
        );

        // Store to local
        await cachedUser(userModel);
        return Right(userModel);
      } else {
        throw ServerException(message: "Credential was null");
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  // Get User
  @override
  Future<Either<Failure, UserEntity>> getUser() async {
    // Get Data From Local
    try {
      final localUser = await userLocalDataSources.getUser();
      return Right(localUser);
    } on CacheException {
      return Left(CacheFailure(errorMessage: 'No Local Data Was Found'));
    }
  }

  // Cached User
  @override
  Future<Either<Failure, void>> cachedUser(UserModel userModel) async {
    try {
      await userLocalDataSources.storeUser(userModel);

      return const Right(null);
    } on ServerException {
      return Left(ServerFailure(errorMessage: "Failed to save"));
    }
  }

  // Sign Out User
  @override
  Future<Either<Failure, void>> signOutUser() async {
    try {
      await firebaseDataSource.signOutWithGoogle();
      await userLocalDataSources.cleanUser();
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  /* Affecting firebase only
  */
  // Registering to firebase and get UserCredential
  @override
  Future<Either<Failure, UserCredential>> registerToFirebase() async {
    try {
      final userCredential = await firebaseDataSource.registerToFirebase();
      return Right(userCredential);
    } on ServerException catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  // Cleaning session if any and no user was signin before app start
  @override
  Future<void> cleanSession() async {
    await firebaseDataSource.cleanCurrentSession();
  }
}
