import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kizu/core/provider/google_sign_in_provider.dart';
import 'package:kizu/features/auth/presentation/components/icon_text_button.dart';

class NavigationScreen extends ConsumerStatefulWidget {
  const NavigationScreen({super.key});

  @override
  ConsumerState<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends ConsumerState<NavigationScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          IconTextButton(
            label: "Sign Out",
            isLoading: isLoading,
            onPressed: () async {
              if (isLoading) return;

              setState(() {
                isLoading = true;
              });

              await ref.watch(googleSignInProvider).disconnect();
              await FirebaseAuth.instance.signOut();

              setState(() {
                isLoading = false;
              });
            },
          ),
        ],
      ),
    );
  }
}
