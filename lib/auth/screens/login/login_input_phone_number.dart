import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kizu/auth/components/display_subtitle_text.dart';
import 'package:kizu/auth/components/icon_text_button.dart';
import 'package:kizu/auth/components/login/phone_number_input.dart';
import 'package:kizu/auth/screens/login/login_verify_phone_number.dart';

class LoginPhoneNumberScreen extends StatelessWidget {
  const LoginPhoneNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 40,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DisplaySubtitleText(
              displayText: "What's your phone number?",
              subtitleText:
                  "By clicking continue you agree to our Terms and Condition",
            ),
            const SizedBox(
              height: 20,
            ),
            const PhoneNumberInput(),
            const Spacer(),
            IconTextButton(
              label: "Continue",
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const VerifyPhoneNumberScreen(),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 6,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text.rich(
                TextSpan(
                  text: "Lost your phone number? ",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0.6),
                      ),
                  children: [
                    TextSpan(
                      text: "Proceed with email",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          print("Clicked");
                        },
                    ),
                    TextSpan(
                      text: " instead",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onBackground
                                .withOpacity(0.6),
                          ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
