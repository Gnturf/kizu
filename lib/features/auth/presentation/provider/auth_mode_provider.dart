import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AuthMode { none, signin, signup }

class AuthModeProvider extends ChangeNotifier {
  AuthMode authMode;

  AuthModeProvider({
    this.authMode = AuthMode.none,
  });

  void setAuthMode(AuthMode authMode) {
    this.authMode = authMode;
    notifyListeners();
  }
}

final authModeProvider = ChangeNotifierProvider<AuthModeProvider>(
  (ref) => AuthModeProvider(),
);
