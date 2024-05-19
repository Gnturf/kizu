import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kizu/auth/presentation/components/display_subtitle_text.dart';
import 'package:kizu/auth/presentation/components/login/OTPInput/otp_input.dart';
import 'package:kizu/auth/presentation/components/login/resend_sms_verification.dart';

class VerifyPhoneNumberScreen extends StatelessWidget {
  const VerifyPhoneNumberScreen({super.key});

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
            DisplaySubtitleText(
              displayText: "Please enter the code we send you :)",
              child: Text.rich(
                TextSpan(
                  text:
                      "We've send a text message along with the OTP to your phone number ",
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0.6),
                      ),
                  children: [
                    TextSpan(
                      text: "+62888XXXXXXXX",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(
                              color: Theme.of(context).colorScheme.secondary),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          print("Clicked");
                        },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Align(alignment: Alignment.center, child: OTPInput()),
            const SizedBox(
              height: 40,
            ),
            const ResendSMSVerification(),
          ],
        ),
      ),
    );
  }
}
