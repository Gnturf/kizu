import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kizu/features/auth/presentation/components/snackbar/custom_snack_bar.dart';
import 'package:kizu/features/auth/presentation/components/display_subtitle_text.dart';
import 'package:kizu/features/auth/presentation/components/icon_text_button.dart';
import 'package:kizu/features/auth/presentation/components/signup/country_select.dart';
import 'package:kizu/features/auth/presentation/provider/user_provider.dart';
import 'package:kizu/features/auth/presentation/screens/signup/signup_password_create.dart';
import 'package:kizu/core/connection_status.dart';
import 'package:kizu/core/params/user_params.dart';

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
              onPressed: isLoading
                  ? () {}
                  : () async {
                      // Checking if there was connection
                      if (connectionStatus == ConnectionStatus.connected) {
                        setState(() {
                          isLoading = true;
                        });

                        // Registering to Firebase and Getting UserCredential
                        final userCredential = await ref
                            .watch(userProvider)
                            .registerUserToFirebase();

                        setState(() {
                          isLoading = false;
                        });

                        userCredential.fold(
                          (newFailure) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              customSnackBar(
                                context,
                                newFailure.errorMessage,
                                Colors.red,
                              ),
                            );
                          },
                          (userCredential) {
                            UserParams userParams =
                                UserParams(userCredential: userCredential);

                            // TODO: Check if user was new or old : Immediately Navigate to the next page : Check if user already has data at custom database ? Navigate to chat screen : Navigate to the next page

                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return PasswordCreateScreen(
                                    userParams: userParams,
                                  );
                                },
                              ),
                            );
                          },
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          customSnackBar(
                            context,
                            "Please check your internet connection",
                            Colors.red,
                          ),
                        );
                      }
                    },
            )
          ],
        ),
      ),
    );
  }
}
