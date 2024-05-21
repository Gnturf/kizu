import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kizu/core/errors/failure.dart';
import 'package:kizu/features/auth/business/entity/user_entity.dart';
import 'package:kizu/features/auth/business/repository/user_repository.dart';
import 'package:kizu/features/auth/business/usecases/register_to_firebase.dart';
import 'package:kizu/features/auth/business/usecases/get_user.dart';
import 'package:kizu/features/auth/business/usecases/signout_user.dart';
import 'package:kizu/features/auth/data/datasources/firebase_data_source.dart';
import 'package:kizu/features/auth/data/datasources/local_data_source.dart';
import 'package:kizu/core/params/user_params.dart';
import 'package:kizu/features/auth/data/repositoriesImpl/user_repository_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  UserEntity? user;
  Failure? failure;

  UserProvider({
    this.user,
  });

  Future<void> registerUser({
    required UserParams userParams,
  }) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final googleSignIn = GoogleSignIn();

    final UserRepository userRepository = UserRepositoryImpl(
      firebaseDataSource: FirebaseDataSource(googleSignIn: googleSignIn),
      userLocalDataSources:
          UserLocalDataSourcesImpl(sharedPreferences: sharedPreferences),
    );

    final failureOrUser = await userRepository.registerUser(user: userParams);

    failureOrUser.fold(
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
    notifyListeners();
  }

  void eitherFailureOrUser() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final googleSignIn = GoogleSignIn();

    final UserRepository userRepository = UserRepositoryImpl(
      firebaseDataSource: FirebaseDataSource(googleSignIn: googleSignIn),
      userLocalDataSources:
          UserLocalDataSourcesImpl(sharedPreferences: sharedPreferences),
    );

    final failureOrUser = await GetUser(userRepository: userRepository).call();

    failureOrUser.fold(
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
  }

  Future<Either<Failure, UserCredential>> registerUserToFirebase() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final googleSignIn = GoogleSignIn();

    final UserRepository userRepository = UserRepositoryImpl(
      firebaseDataSource: FirebaseDataSource(googleSignIn: googleSignIn),
      userLocalDataSources:
          UserLocalDataSourcesImpl(sharedPreferences: sharedPreferences),
    );

    return await RegisterUserToFirebase(userRepository: userRepository).call();
  }

  Future<Either<Failure, void>> signOutUser() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final googleSignIn = GoogleSignIn();

    final UserRepository userRepository = UserRepositoryImpl(
      firebaseDataSource: FirebaseDataSource(googleSignIn: googleSignIn),
      userLocalDataSources:
          UserLocalDataSourcesImpl(sharedPreferences: sharedPreferences),
    );

    return await SignOutUser(userRepository: userRepository).call();
  }

  Future<void> cleanSession() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final googleSignIn = GoogleSignIn();

    final UserRepository userRepository = UserRepositoryImpl(
      firebaseDataSource: FirebaseDataSource(googleSignIn: googleSignIn),
      userLocalDataSources:
          UserLocalDataSourcesImpl(sharedPreferences: sharedPreferences),
    );
    await userRepository.cleanSession();
  }
}

final userProvider =
    ChangeNotifierProvider<UserProvider>((ref) => UserProvider());
