import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kizu/core/errors/failure.dart';
import 'package:kizu/features/auth/presentation/provider/user_provider.dart';
import 'package:kizu/features/chat/screens/temp_chat.dart';
import 'package:kizu/features/welcome/screens/welcome.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User? user = snapshot.data;
            if (user == null) {
              ref.watch(userProvider).cleanSession();

              return const WelcomeScreen();
            }

            try {
              ref.read(userProvider).eitherFailureOrUser();
              // ignore: empty_catches
            } on CacheFailure {}
            return const TempChat();
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
