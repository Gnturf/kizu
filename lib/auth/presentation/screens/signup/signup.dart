import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kizu/auth/data/models/user_params.dart';
import 'package:kizu/auth/presentation/components/connection/connection_snack_bar.dart';
import 'package:kizu/auth/presentation/components/display_subtitle_text.dart';
import 'package:kizu/auth/presentation/components/icon_text_button.dart';
import 'package:kizu/auth/presentation/components/signup/country_select.dart';
import 'package:kizu/auth/presentation/provider/user_provider.dart';
import 'package:kizu/auth/presentation/screens/signup/signup_password_create.dart';
import 'package:kizu/core/connection_status.dart';

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

                        // Getting OAuthCredential
                        final oAuthCredential =
                            await ref.watch(userProvider).getOAuthCredential();

                        setState(() {
                          isLoading = false;
                        });

                        // Creating the userParams
                        final userParams = UserParams(
                          oAuthCredential: oAuthCredential,
                        );

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return PasswordCreateScreen(
                                userParams: userParams,
                              );
                            },
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          connectionSnackBar(context),
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
