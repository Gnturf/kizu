import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kizu/core/provider/google_sign_in_provider.dart';
import 'package:kizu/features/auth/data/repositories_impl/auth_repository_impl.dart';

import 'package:kizu/core/errors/failure.dart';
import 'package:kizu/core/params/user_params.dart';

import 'package:kizu/features/auth/business/repository/auth_repository.dart';
import 'package:kizu/features/auth/business/usecases/clean_session.dart';
import 'package:kizu/features/auth/business/usecases/create_oauth_credential.dart';
import 'package:kizu/features/auth/business/usecases/is_user_already_exist.dart';
import 'package:kizu/features/auth/business/usecases/register_to_firebase.dart';
import 'package:kizu/features/auth/business/usecases/register_to_remote.dart';
import 'package:kizu/features/auth/data/datasources/firebase_data_source.dart';
import 'package:kizu/features/auth/data/datasources/remote_data_source.dart';

class AuthProvider extends ChangeNotifier {
  Failure? failure;

  GoogleSignIn googleSignIn;

  AuthProvider({
    required this.googleSignIn,
  });

  /*
    Auth User Repository
  */
  // Create OAuthCredential
  Future<Either<Failure, OAuthCredential>> createOAuthCredential() async {
    final AuthRepository userRepository = AuthRepositoryImpl(
      firebaseDataSource: FirebaseDataSourceImpl(
        googleSignIn: googleSignIn,
      ),
      remoteDataSource: RemoteDataSourceImpl(domain: '10.0.2.2'),
    );

    return await CreateOAuthCredential(repository: userRepository).call();
  }

  // Clean Session
  Future<void> cleanSession() async {
    final AuthRepository userRepository = AuthRepositoryImpl(
      firebaseDataSource: FirebaseDataSourceImpl(googleSignIn: googleSignIn),
      remoteDataSource: RemoteDataSourceImpl(domain: '10.0.2.2'),
    );

    return await CleanSession(repository: userRepository).call();
  }

  // Check if user already exist
  Future<Either<Failure, bool>> isUserAlreadyExist() async {
    final AuthRepository userRepository = AuthRepositoryImpl(
      firebaseDataSource: FirebaseDataSourceImpl(googleSignIn: googleSignIn),
      remoteDataSource: RemoteDataSourceImpl(domain: '10.0.2.2'),
    );

    return await IsUserAlreadyExist(repository: userRepository).call();
  }

  // Register Or Login to firebase
  Future<Either<Failure, UserCredential>> registerToFirebase({
    required OAuthCredential oAuthCredential,
  }) async {
    final AuthRepository userRepository = AuthRepositoryImpl(
      firebaseDataSource: FirebaseDataSourceImpl(googleSignIn: googleSignIn),
      remoteDataSource: RemoteDataSourceImpl(domain: '10.0.2.2'),
    );

    return await RegisterToFirebase(repository: userRepository)
        .call(oAuthCredential);
  }

  // Register to remote
  Future<Either<Failure, void>> registerToRemote({
    required UserParams userParams,
  }) async {
    final AuthRepository userRepository = AuthRepositoryImpl(
      firebaseDataSource: FirebaseDataSourceImpl(googleSignIn: googleSignIn),
      remoteDataSource: RemoteDataSourceImpl(domain: '10.0.2.2'),
    );

    return await RegisterToRemote(repository: userRepository).call(userParams);
  }
}

final authProvider = ChangeNotifierProvider<AuthProvider>(
  (ref) => AuthProvider(
    googleSignIn: ref.watch(googleSignInProvider),
  ),
);
