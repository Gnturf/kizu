import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kizu/core/errors/exception.dart';
import 'package:kizu/core/errors/failure.dart';
import 'package:kizu/features/chat/business/entity/user_entity.dart';
import 'package:kizu/features/chat/business/repository/user_repository.dart';
import 'package:kizu/features/chat/data/datasources/local_user_data_source.dart';
import 'package:kizu/features/chat/data/datasources/remote_user_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  LocalUserDataSource localUserDataSource;
  RemoteUserDataSource remoteUserDataSource;

  UserRepositoryImpl({
    required this.localUserDataSource,
    required this.remoteUserDataSource,
  });

  @override
  Future<Either<Failure, UserEntity>> fetchUser() async {
    try {
      /// Try Fetching From Local
      final user = await localUserDataSource.fetchUser();
      return Right(user);
    } on CacheException {
      final fAuthCurrentUser = FirebaseAuth.instance.currentUser;
      if (fAuthCurrentUser == null) {
        return Left(
            SystemFailure(errorMessage: "FirebaseAuth current user was null"));
      }

      final idToken = await fAuthCurrentUser.getIdToken();
      if (idToken == null) {
        return Left(
            SystemFailure(errorMessage: "FirebaseAuth ID Token was null"));
      }

      /// Try Fetching From Remote
      final user = await remoteUserDataSource.fetchUser(idToken);
      return Right(user);
    } catch (e) {
      return Left(SystemFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> cacheUser(UserEntity user) async {
    try {
      await localUserDataSource.cachedUser(user);

      return const Right(null);
    } catch (e) {
      return Left(SystemFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<void> cleanCachedUser() async {
    await localUserDataSource.cleanCachedUser();
  }
}
