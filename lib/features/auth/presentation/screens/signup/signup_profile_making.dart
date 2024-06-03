import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kizu/features/auth/presentation/components/display_subtitle_text.dart';
import 'package:kizu/features/auth/presentation/components/icon_text_button.dart';
import 'package:kizu/features/auth/presentation/components/snackbar/custom_snack_bar.dart';
import 'package:kizu/features/auth/presentation/provider/auth_mode_provider.dart';
import 'package:kizu/features/auth/presentation/provider/user_params_provider.dart';
import 'package:kizu/features/auth/presentation/provider/auth_provider.dart';

class ProfileMakingScreen extends ConsumerStatefulWidget {
  const ProfileMakingScreen({
    super.key,
  });

  @override
  ConsumerState<ProfileMakingScreen> createState() =>
      _ProfileMakingScreenState();
}

class _ProfileMakingScreenState extends ConsumerState<ProfileMakingScreen> {
  bool isLoading = false;
  File? selectedImage;
  String? errorText;

  // Profile Name Controller
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              displayText: "Decide how you want people to see you!",
              subtitleText: "Create your profile",
            ),
            const SizedBox(
              height: 40,
            ),
            Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {},
                child: Container(
                    clipBehavior: Clip.hardEdge,
                    width: 116,
                    height: 116,
                    decoration: BoxDecoration(
                      color: Colors.white30,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: selectedImage != null
                        ? Image.file(
                            selectedImage!,
                            fit: BoxFit.cover,
                          )
                        : Center(
                            child: Icon(
                              Icons.camera_alt_rounded,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                            ),
                          )),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            TextField(
              controller: _controller,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displaySmall,
              maxLength: 20,
              decoration: InputDecoration(
                errorText: errorText,
                counterText: "",
                hintText: "What's your name?",
                hintStyle: Theme.of(context).textTheme.displaySmall!.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.6),
                    ),
              ),
            ),
            const Spacer(),
            IconTextButton(
              label: "Create your account",
              isLoading: isLoading,
              onPressed: isLoading
                  ? () {}
                  : () async {
                      ref
                          .read(userParamsProvider)
                          .setDisplayName(_controller.text);

                      /// Set AuthMode state to AuthMode.register
                      ref.read(authModeProvider).setAuthMode(AuthMode.signup);

                      // Register To Firebase
                      /// Get the oAuthCredential from UserParams provider
                      final oAuthCredential = ref
                          .read(userParamsProvider)
                          .userParams
                          .oAuthCredential;

                      /// Check if the oAuthCredential was null
                      if (oAuthCredential == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          customSnackBar(
                            context,
                            "OAuth credential was null",
                            Colors.red,
                          ),
                        );

                        return;
                      }

                      setState(() {
                        isLoading = true;
                      });

                      /// Register user to firebase
                      final eitherFailureOrUserCredential =
                          await ref.read(authProvider).registerToFirebase(
                                oAuthCredential: oAuthCredential,
                              );

                      setState(() {
                        isLoading = false;
                      });

                      eitherFailureOrUserCredential.fold(
                        (newFailure) {
                          /// If register to firebase failed
                          ScaffoldMessenger.of(context).showSnackBar(
                            customSnackBar(
                              context,
                              newFailure.errorMessage,
                              Colors.red,
                            ),
                          );
                        },
                        (userCredential) {
                          /// If register to firebase success
                          ref
                              .read(userParamsProvider)
                              .setUserCredential(userCredential);
                        },
                      );

                      /// Navigate to appropiate screen
                      Navigator.of(context).popUntil((route) => route.isFirst);

                      print(
                          ref.read(userParamsProvider).userParams.displayName);
                    },
            )
          ],
        ),
      ),
    );
  }
}
