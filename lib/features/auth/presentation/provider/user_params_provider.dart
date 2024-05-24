import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kizu/core/params/user_params.dart';

class UserParamsProvider extends ChangeNotifier {
  UserParams userParams;

  UserParamsProvider({required this.userParams});

  void setUserCredential(UserCredential userCredential) {
    userParams.userCredential = userCredential;
    notifyListeners();
  }

  void setOAuthCredential(OAuthCredential oAuthCredential) {
    userParams.oAuthCredential = oAuthCredential;
    notifyListeners();
  }

  void setDisplayName(String displayName) {
    userParams.displayName = displayName;
    notifyListeners();
  }

  void setPassword(String password) {
    userParams.password = password;
    notifyListeners();
  }
}

final userParamsProvider = ChangeNotifierProvider(
  (ref) => UserParamsProvider(
    userParams: UserParams(),
  ),
);
