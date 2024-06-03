import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kizu/core/errors/exception.dart';
import 'package:kizu/core/errors/failure.dart';
import 'package:kizu/core/params/user_params.dart';
import 'package:kizu/features/auth/data/datasources/firebase_data_source.dart';
import 'package:kizu/features/auth/business/repository/auth_repository.dart';
import 'package:kizu/features/auth/data/datasources/remote_data_source.dart';
import 'package:kizu/features/chat/data/model/user_model.dart';

class AuthRepositoryImpl extends AuthRepository {
  final FirebaseAuthDataSource firebaseDataSource;
  final RemoteAuthDataSource remoteDataSource;

  AuthRepositoryImpl({
    required this.firebaseDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, OAuthCredential>> createOAuthCredential() async {
    try {
      return Right(await firebaseDataSource.createOAuthCredential());
    } on ServerException catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  // Cleaning session if any and no user was signin before app start
  @override
  Future<Either<Failure, void>> cleanSession() async {
    try {
      await firebaseDataSource.cleanSession();

      return const Right(null);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> isUserAlreadyExist() async {
    try {
      final email = firebaseDataSource.getUserEmail();
      final isUserExist = await remoteDataSource.isUserExist(email);

      if (isUserExist) {
        return const Right(true);
      }

      return const Right(false);
    } catch (e) {
      return Left(
        ServerFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, UserCredential>> registerToFirebase({
    required OAuthCredential oAuthCredential,
  }) async {
    try {
      final userCredential = await firebaseDataSource
          .registerOrSignInToFirebase(oAuthCredential: oAuthCredential);

      return Right(userCredential);
    } on ServerException catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> registerToRemote({
    required UserParams userParams,
  }) async {
    try {
      /// Check if
      if (userParams.userCredential == null) {
        return Left(
          SystemFailure(errorMessage: "userCredential in userParams was null"),
        );
      }

      if (userParams.displayName == null) {
        return Left(
          SystemFailure(errorMessage: "displayName in userParams was null"),
        );
      }

      if (userParams.password == null) {
        return Left(
          SystemFailure(errorMessage: "password in userParams was null"),
        );
      }

      if (userParams.userCredential!.user == null) {
        return Left(
            SystemFailure(errorMessage: "UserCredential.user was null"));
      }

      /// Mapping userParams to UserModel
      final UserModel userModel = UserModel(
        uid: userParams.userCredential!.user!.uid,
        displayName: userParams.displayName!,
        email: userParams.userCredential!.user!.email!,
        password: userParams.password!,
      );

      /// Getting the idToken
      if (FirebaseAuth.instance.currentUser == null) {
        return Left(
            ServerFailure(errorMessage: "FirebaseAuth instance was null"));
      }

      final idToken = await FirebaseAuth.instance.currentUser!.getIdToken();
      if (idToken == null) {
        return Left(ServerFailure(errorMessage: "ID Token was null"));
      }

      await remoteDataSource.registerToRemote(userModel, idToken);

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
