import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ResendSMSVerification extends StatefulWidget {
  const ResendSMSVerification({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ResendSMSVerificationState();
  }
}

class _ResendSMSVerificationState extends State<ResendSMSVerification> {
  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: "Not receiving the code? ",
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color:
                  Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
            ),
        children: [
          TextSpan(
            text: "Resend It",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                print("Clicked");
              },
          ),
          TextSpan(
            text: " (25s)",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.6),
                ),
          ),
        ],
      ),
    );
  }
}
