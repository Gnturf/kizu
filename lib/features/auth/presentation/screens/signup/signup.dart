import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kizu/core/connection_status.dart';
import 'package:kizu/core/errors/failure.dart';
import 'package:kizu/features/auth/presentation/components/dialog/user_exist_dialog.dart';
import 'package:kizu/features/auth/presentation/components/display_subtitle_text.dart';
import 'package:kizu/features/auth/presentation/components/icon_text_button.dart';
import 'package:kizu/features/auth/presentation/components/signup/country_select.dart';
import 'package:kizu/features/auth/presentation/components/snackbar/custom_snack_bar.dart';
import 'package:kizu/features/auth/presentation/provider/auth_mode_provider.dart';
import 'package:kizu/features/auth/presentation/provider/user_params_provider.dart';
import 'package:kizu/features/auth/presentation/provider/user_provider.dart';
import 'package:kizu/features/auth/presentation/screens/signup/signup_password_create.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final connectionStatus = ref.watch(connectionStatusProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.chevron_left,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
            size: 36,
          ),
          iconSize: 36,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 40,
        ),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DisplaySubtitleText(
              displayText: "Sorryy, but we need you to verify your identity :)",
              subtitleText:
                  "By continuing with verification, you agree with YUME Terms and Condition of Use and Privacy Policys",
            ),
            const SizedBox(
              height: 40,
            ),
            const CountrySelect(),
            const Spacer(),
            IconTextButton.inverted(
              label: "Verify with Google",
              icon: Icons.abc,
              isLoading: isLoading,
              onPressed: () async {
                // Doing Nothing of loading was happening
                if (isLoading) return;

                if (connectionStatus == ConnectionStatus.disconnected) {
                  // If internet connection was not found
                  ScaffoldMessenger.of(context).showSnackBar(
                    customSnackBar(
                      context,
                      "Please Check Your Internet Connection",
                      Colors.red,
                    ),
                  );

                  return;
                }

                setState(() {
                  isLoading = true;
                });

                // Try Getting OAuthCredential
                final eitherFailureOrOAuth =
                    await ref.watch(userProvider).createOAuthCredential();

                // Check if getting OAuth Credential was success
                eitherFailureOrOAuth.fold(
                  (newFailure) {
                    handleFailure(newFailure);
                  },
                  (oAuthCredential) async {
                    await handleSuccessCreatingOAuth(oAuthCredential);
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }

  // Handle Anything That Was fail
  void handleFailure(Failure newFailure) {
    ScaffoldMessenger.of(context).showSnackBar(
      customSnackBar(context, newFailure.errorMessage, Colors.red),
    );

    setState(() {
      isLoading = false;
    });
  }

  // handler if OAauth was successfully created
  Future<void> handleSuccessCreatingOAuth(
    OAuthCredential oAuthCredential,
  ) async {
    /// Check if the user account was already exist
    final isUserAlreadyExist =
        await ref.read(userProvider).isUserAlreadyExist();

    isUserAlreadyExist.fold(
      (newFailure) {
        /// Clean the session if something happen here
        ref.read(userProvider).cleanSession();

        handleFailure(newFailure);
      },
      (isExist) {
        if (isExist) {
          handleIfUserAlreadyExist(oAuthCredential);

          return;
        }

        ref.read(userParamsProvider).setOAuthCredential(oAuthCredential);

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return const PasswordCreateScreen();
            },
          ),
        );
      },
    );
  }

  // handler if user already exist
  void handleIfUserAlreadyExist(OAuthCredential oAuthCredential) {
    showDialog(
      barrierColor: const Color.fromRGBO(0, 0, 0, 0),
      context: context,
      builder: (context) {
        return UserExistDialog(
          onCancel: () {
            /// Clean the Session if user already exist
            ref.read(userProvider).cleanSession();

            /// Pop the dialog
            Navigator.pop(context);

            setState(() {
              isLoading = false;
            });
          },
          onProceed: () async {
            Navigator.pop(context);
            await handleUserExistProceed(oAuthCredential);
          },
        );
      },
    );
  }

  Future<void> handleUserExistProceed(OAuthCredential oAuthCredential) async {
    ref.read(authModeProvider).setAuthMode(AuthMode.signin);
    ref.read(userParamsProvider).setOAuthCredential(oAuthCredential);

    final eitherFailureOrUserCredential =
        await ref.read(userProvider).registerToFirebase(
              oAuthCredential: oAuthCredential,
            );

    eitherFailureOrUserCredential.fold(
      (newFailure) {
        handleFailure(newFailure);
      },
      (userCredential) {
        ref.watch(userParamsProvider).setUserCredential(userCredential);

        Navigator.of(context).popUntil((route) => route.isFirst);
      },
    );
  }
}
