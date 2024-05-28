import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kizu/features/auth/presentation/provider/auth_mode_provider.dart';
import 'package:kizu/features/auth/presentation/screens/loading.dart';
import 'package:kizu/features/chat/presentation/screens/navigation_screen.dart';
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
              return const WelcomeScreen();
            } else {
              if (ref.watch(authModeProvider).authMode != AuthMode.none) {
                return LoadingScreen(
                    authMode: ref.read(authModeProvider).authMode);
              }

              return const NavigationScreen();
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
