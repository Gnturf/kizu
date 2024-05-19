import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kizu/auth/business/entity/user_entity.dart';
import 'package:kizu/auth/business/usecases/creating_oauth_cred.dart';
import 'package:kizu/auth/business/usecases/signout_user.dart';
import 'package:kizu/auth/data/datasources/firebase_data_source.dart';
import 'package:kizu/auth/data/models/user_params.dart';
import 'package:kizu/auth/data/repositories_impl/user_repository_impl.dart';

class UserProvider extends ChangeNotifier {
  UserEntity? user;
  final UserRepositoryImpl userRepository = UserRepositoryImpl(
    firebaseDataSource: FirebaseDataSource(
      googleSignIn: GoogleSignIn(),
    ),
  );

  UserProvider({
    this.user,
  });

  Future<OAuthCredential> getOAuthCredential() async {
    return await CreatingOAuthCred(userRepository: userRepository).call();
  }

  Future<void> signOutUser() async {
    await SignOutUser(userRepository: userRepository).call();
  }

  Future<void> cleanSession() async {
    await userRepository.cleanSession();
  }

  Future<void> registerUser({
    required UserParams userParams,
  }) async {
    user = await userRepository.registerUser(user: userParams);
    notifyListeners();
  }
}

final userProvider =
    ChangeNotifierProvider<UserProvider>((ref) => UserProvider());
