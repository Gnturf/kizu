import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kizu/core/errors/failure.dart';
import 'package:kizu/features/chat/business/entity/user_entity.dart';
import 'package:kizu/features/chat/business/repository/user_repository.dart';
import 'package:kizu/features/chat/business/usecases/cache_user.dart';
import 'package:kizu/features/chat/business/usecases/clean_cache_user.dart';
import 'package:kizu/features/chat/business/usecases/fetch_user.dart';
import 'package:kizu/features/chat/data/datasources/local_user_data_source.dart';
import 'package:kizu/features/chat/data/datasources/remote_user_data_source.dart';
import 'package:kizu/features/chat/data/repository_impl/user_repository_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  UserEntity? user;
  Failure? failure;

  Future<Either<Failure, UserEntity>> fetchUser() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final UserRepository userRepository = UserRepositoryImpl(
      localUserDataSource:
          LocalUserDataSourcesImpl(sharedPreferences: sharedPreferences),
      remoteUserDataSource: RemoteUserDataSourceImpl(domain: '10.0.2.2'),
    );

    final eitherFailureOrUser =
        await FetchUser(userRepository: userRepository).call();

    eitherFailureOrUser.fold(
      (newFailure) {
        user = null;
        failure = newFailure;
        notifyListeners();
      },
      (newUser) {
        user = newUser;
        failure = null;
        notifyListeners();
      },
    );

    return eitherFailureOrUser;
  }

  Future<Either<Failure, void>> cacheUser(UserEntity user) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final UserRepository userRepository = UserRepositoryImpl(
      localUserDataSource:
          LocalUserDataSourcesImpl(sharedPreferences: sharedPreferences),
      remoteUserDataSource: RemoteUserDataSourceImpl(domain: '10.0.2.2'),
    );

    return await CacheUser(userRepository: userRepository).call(user);
  }

  void cleanProvider() {
    user = null;
    failure = null;
    notifyListeners();
  }

  Future<void> cleanCachedUser() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final UserRepository userRepository = UserRepositoryImpl(
      localUserDataSource:
          LocalUserDataSourcesImpl(sharedPreferences: sharedPreferences),
      remoteUserDataSource: RemoteUserDataSourceImpl(domain: '10.0.2.2'),
    );

    return await CleanCachedUser(userRepository: userRepository).call();
  }
}

final userProvider = ChangeNotifierProvider<UserProvider>(
  (ref) => UserProvider(),
);
