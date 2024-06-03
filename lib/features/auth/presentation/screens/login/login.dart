import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kizu/core/provider/connection_status.dart';
import 'package:kizu/core/errors/failure.dart';
import 'package:kizu/features/auth/presentation/components/display_subtitle_text.dart';
import 'package:kizu/features/auth/presentation/components/icon_text_button.dart';
import 'package:kizu/features/auth/presentation/components/snackbar/custom_snack_bar.dart';
import 'package:kizu/features/auth/presentation/provider/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
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
              displayText: "Welcome back,",
              displayText2: "Glad to see you again!",
              subtitleText: "How do you want to proceed?",
            ),
            const Spacer(),
            IconTextButton.inverted(
              label: "Proceed with Google",
              icon: Icons.abc,
              isLoading: isLoading,
              onPressed: () async {
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

                final failureOrOAuthCredential =
                    await ref.read(authProvider).createOAuthCredential();
                failureOrOAuthCredential.fold(
                  (newFailure) {
                    handleFailure(newFailure);
                  },
                  (oAuthCredential) async {
                    await ref
                        .read(authProvider)
                        .registerToFirebase(oAuthCredential: oAuthCredential);

                    setState(() {
                      isLoading = false;
                    });

                    if (!mounted) return;
                    Navigator.of(context).popUntil((route) => route.isFirst);
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
}
