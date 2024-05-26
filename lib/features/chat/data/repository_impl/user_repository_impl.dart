import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kizu/core/datasource/local_user_data_source.dart';
import 'package:kizu/core/entity/user_entity.dart';
import 'package:kizu/core/errors/exception.dart';
import 'package:kizu/core/errors/failure.dart';
import 'package:kizu/features/chat/business/repository/user_repository.dart';
import 'package:kizu/features/chat/data/datasources/firebase_user_data_source.dart';
import 'package:kizu/features/chat/data/datasources/remote_user_data_sources.dart';

class ChatUserRepositoryImpl implements ChatUserRepository {
  FirebaseUserDataSource firebaseDataSource;
  LocalUserDataSource localDataSource;
  RemoteUserDataSource remoteDataSource;

  ChatUserRepositoryImpl({
    required this.firebaseDataSource,
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await firebaseDataSource.signOut();
      await localDataSource.cleanCachedUser();

      return const Right(null);
    } catch (e) {
      return Left(SystemFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> fetchUser() async {
    try {
      // Try fetching from local first
      final user = await localDataSource.fetchUser();
      return Right(user);
    } on CacheException {
      return await _fetchUserFromRemote();
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  /*
    Helper Function
  */
  Future<Either<Failure, UserEntity>> _fetchUserFromRemote() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        return Left(ServerFailure(
            errorMessage:
                "Failed to fetch from server: FirebaseAuth.instance.currentUser was null"));
      }
      final idToken = await currentUser.getIdToken();
      if (idToken == null) {
        return Left(ServerFailure(errorMessage: "ID Token was null"));
      }

      final userModel = await remoteDataSource.getUser(idToken);
      return Right(userModel);
    } catch (e) {
      return Left(ServerFailure(errorMessage: "Exception: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, void>> cachedUser(UserEntity userEntity) {
    // TODO: implement cachedUser
    throw UnimplementedError();
  }
}
