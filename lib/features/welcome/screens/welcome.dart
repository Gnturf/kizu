import 'package:flutter/material.dart';
import 'package:kizu/features/auth/presentation/screens/login/login.dart';
import 'package:kizu/features/auth/presentation/screens/signup/signup.dart';
import 'package:kizu/features/welcome/components/icon_text_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 40,
        ),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Welcome to YUME",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Connect with your family and friends more easily!",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.6)),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const Spacer(),
            IconTextButton(
              label: "Login",
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            IconTextButton.inverted(
              label: "Sign In",
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SignupScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
