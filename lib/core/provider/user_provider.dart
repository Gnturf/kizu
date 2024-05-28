import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:kizu/core/errors/failure.dart';
import 'package:kizu/core/params/user_params.dart';
import 'package:kizu/core/entity/user_entity.dart';

import 'package:kizu/features/auth/business/repository/user_repository.dart';
import 'package:kizu/features/auth/business/usecases/cached_user.dart';
import 'package:kizu/features/auth/business/usecases/clean_session.dart';
import 'package:kizu/features/auth/business/usecases/create_oauth_credential.dart';
import 'package:kizu/features/auth/business/usecases/is_user_already_exist.dart';
import 'package:kizu/features/auth/business/usecases/register_to_firebase.dart';
import 'package:kizu/features/auth/business/usecases/register_to_remote.dart';
import 'package:kizu/features/auth/data/repositoriesImpl/user_repository_impl.dart';
import 'package:kizu/features/auth/data/datasources/firebase_data_source.dart';
import 'package:kizu/features/auth/data/datasources/local_data_source.dart';
import 'package:kizu/features/auth/data/datasources/remote_data_source.dart';

import 'package:kizu/features/chat/business/repository/user_repository.dart';
import 'package:kizu/features/chat/business/usecases/sign_out.dart';
import 'package:kizu/features/chat/data/datasources/firebase_user_data_source.dart';
import 'package:kizu/features/chat/data/datasources/local_user_data_sources.dart';
import 'package:kizu/features/chat/data/datasources/remote_user_data_sources.dart';
import 'package:kizu/features/chat/data/repositoryImpl/user_repository_impl.dart';
import 'package:kizu/features/chat/business/usecases/fetch_user.dart';

class UserProvider extends ChangeNotifier {
  Failure? failure;
  UserEntity? userEntity;

  GoogleSignIn googleSignIn;

  UserProvider({
    required this.googleSignIn,
  });

  /*
    Auth User Repository
  */
  // Create OAuthCredential
  Future<Either<Failure, OAuthCredential>> createOAuthCredential() async {
    final AuthUserRepository userRepository = AuthUserRepositoryImpl(
      firebaseDataSource: FirebaseDataSourceImpl(
        googleSignIn: googleSignIn,
      ),
      userLocalDataSources: UserLocalDataSourcesImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      remoteDataSource: RemoteDataSourceImpl(domain: '10.0.2.2'),
    );

    return await CreateOAuthCredential(repository: userRepository).call();
  }

  // Clean Session
  Future<void> cleanSession() async {
    final AuthUserRepository userRepository = AuthUserRepositoryImpl(
      firebaseDataSource: FirebaseDataSourceImpl(googleSignIn: googleSignIn),
      userLocalDataSources: UserLocalDataSourcesImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      remoteDataSource: RemoteDataSourceImpl(domain: '10.0.2.2'),
    );

    return await CleanSession(repository: userRepository).call();
  }

  // Check if user already exist
  Future<Either<Failure, bool>> isUserAlreadyExist() async {
    final AuthUserRepository userRepository = AuthUserRepositoryImpl(
      firebaseDataSource: FirebaseDataSourceImpl(googleSignIn: googleSignIn),
      userLocalDataSources: UserLocalDataSourcesImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      remoteDataSource: RemoteDataSourceImpl(domain: '10.0.2.2'),
    );

    return await IsUserAlreadyExist(repository: userRepository).call();
  }

  // Register Or Login to firebase
  Future<Either<Failure, UserCredential>> registerToFirebase({
    required OAuthCredential oAuthCredential,
  }) async {
    final AuthUserRepository userRepository = AuthUserRepositoryImpl(
      firebaseDataSource: FirebaseDataSourceImpl(googleSignIn: googleSignIn),
      userLocalDataSources: UserLocalDataSourcesImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      remoteDataSource: RemoteDataSourceImpl(domain: '10.0.2.2'),
    );

    return await RegisterToFirebase(repository: userRepository)
        .call(oAuthCredential);
  }

  // Register to remote
  Future<Either<Failure, UserEntity>> registerToRemote({
    required UserParams userParams,
  }) async {
    final AuthUserRepository userRepository = AuthUserRepositoryImpl(
      firebaseDataSource: FirebaseDataSourceImpl(googleSignIn: googleSignIn),
      userLocalDataSources: UserLocalDataSourcesImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      remoteDataSource: RemoteDataSourceImpl(domain: '10.0.2.2'),
    );

    return await RegisterToRemote(repository: userRepository).call(userParams);
  }

  // Cached user
  Future<Either<Failure, void>> cachedUser(UserEntity userEntity) async {
    final AuthUserRepository userRepository = AuthUserRepositoryImpl(
      firebaseDataSource: FirebaseDataSourceImpl(googleSignIn: googleSignIn),
      userLocalDataSources: UserLocalDataSourcesImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      remoteDataSource: RemoteDataSourceImpl(domain: '10.0.2.2'),
    );

    this.userEntity = userEntity;
    notifyListeners();

    return await CachedUser(repository: userRepository).call(userEntity);
  }

  /*
    Chat Feature
  */

  // Fetch User
  Future<Either<Failure, UserEntity>> fetchUser() async {
    final ChatUserRepository userRepository = ChatUserRepositoryImpl(
      firebaseDataSource:
          FirebaseUserDataSourceImpl(googleSignIn: googleSignIn),
      localDataSource: LocalUserDataSourcesImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      remoteDataSource: RemoteUserDataSourceImpl(domain: '10.0.2.2'),
    );

    final eitherFailureOrUserEntity =
        await FetchUser(repository: userRepository).call();

    eitherFailureOrUserEntity.fold(
      (newFailure) {
        failure = newFailure;
        userEntity = null;
        notifyListeners();
      },
      (newUser) {
        failure = null;
        userEntity = newUser;
        notifyListeners();
      },
    );

    return eitherFailureOrUserEntity;
  }

  // Sign Out
  Future<Either<Failure, void>> signOut() async {
    final ChatUserRepository userRepository = ChatUserRepositoryImpl(
      firebaseDataSource:
          FirebaseUserDataSourceImpl(googleSignIn: googleSignIn),
      localDataSource: LocalUserDataSourcesImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      remoteDataSource: RemoteUserDataSourceImpl(domain: '10.0.2.2'),
    );

    return await SignOut(repository: userRepository).call();
  }
}

final userProvider = ChangeNotifierProvider<UserProvider>(
  (ref) => UserProvider(
    googleSignIn: GoogleSignIn(),
  ),
);
