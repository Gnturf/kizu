import 'package:flutter/material.dart';
import 'package:kizu/auth/components/display_subtitle_text.dart';
import 'package:kizu/auth/components/icon_text_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
            // IconTextButton(
            //   label: "Proceed with Phone Number",
            //   icon: Icons.phone,
            //   onPressed: () {
            //     Navigator.of(context).push(
            //       MaterialPageRoute(
            //         builder: (context) => const LoginPhoneNumberScreen(),
            //       ),
            //     );
            //   },
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            IconTextButton.inverted(
              label: "Proceed with Google",
              icon: Icons.abc,
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
