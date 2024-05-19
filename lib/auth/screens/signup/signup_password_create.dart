import 'package:flutter/material.dart';
import 'package:kizu/auth/components/display_subtitle_text.dart';
import 'package:kizu/auth/components/signup/password_insert.dart';
import 'package:kizu/auth/components/signup/single_password_rules.dart';
import 'package:kizu/auth/screens/signup/signup_profile_making.dart';
import 'package:kizu/welcome/components/icon_text_button.dart';

enum PasswordCheck {
  missing8Character,
  missingAtleastOneUppercase,
  missingLowercase,
  missingASymbol,
  missingANumber,
  hasAll
}

class PasswordCreateScreen extends StatefulWidget {
  const PasswordCreateScreen({
    super.key,
  });

  @override
  State<PasswordCreateScreen> createState() => _PasswordCreateScreenState();
}

class _PasswordCreateScreenState extends State<PasswordCreateScreen> {
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();

  String? passwordErrorText;
  String? rePasswordErrorText;

  @override
  void initState() {
    super.initState();
    rePasswordController.addListener(isPasswordMatch);
  }

  @override
  void dispose() {
    passwordController.dispose();
    rePasswordController.dispose();
    super.dispose();
  }

  bool isPasswordMatch() {
    if (passwordController.text != rePasswordController.text) {
      setState(() {
        rePasswordErrorText = "Password was not match";
      });
      return false;
    } else {
      setState(() {
        rePasswordErrorText = null;
      });
    }

    return true;
  }

  PasswordCheck passwordCheck(String password) {
    // Check if the password has at least 8 characters
    if (password.length < 8) {
      return PasswordCheck.missing8Character;
    }

    // Check if the password has at least one uppercase letter
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return PasswordCheck.missingAtleastOneUppercase;
    }

    // Check if the password has at least one lowercase letter
    if (!password.contains(RegExp(r'[a-z]'))) {
      return PasswordCheck.missingLowercase;
    }

    // Check if the password has at least one symbol
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return PasswordCheck.missingASymbol;
    }

    // Check if the password has at least one number
    if (!password.contains(RegExp(r'[0-9]'))) {
      return PasswordCheck.missingANumber;
    }

    // If all conditions are met, return true
    return PasswordCheck.hasAll;
  }

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
              displayText: "Keep Yourself Safe!",
              subtitleText:
                  "Please create a strong password, make sure it has 3 of the following:",
              subtitleChildSpace: 2,
              child: Column(
                children: [
                  SingelPasswordRules(text: "Has at least 8 characters"),
                  SizedBox(
                    height: 2,
                  ),
                  SingelPasswordRules(text: "An uppercase letter"),
                  SizedBox(
                    height: 2,
                  ),
                  SingelPasswordRules(text: "A lowercase letter"),
                  SizedBox(
                    height: 2,
                  ),
                  SingelPasswordRules(text: "A number"),
                  SizedBox(
                    height: 2,
                  ),
                  SingelPasswordRules(text: "A symbol"),
                ],
              ),
            ),
            const SizedBox(
              height: 36,
            ),
            // Put it here
            PasswordInsert(
              hintText: "Password",
              errorText: passwordErrorText,
              controller: passwordController,
            ),
            const SizedBox(
              height: 30,
            ),
            PasswordInsert(
              hintText: "Re-enter Password",
              errorText: rePasswordErrorText,
              controller: rePasswordController,
            ),
            const Spacer(),
            IconTextButton(
              label: "Continue",
              onPressed: () {
                if (isPasswordMatch()) {
                  final passwordStatus = passwordCheck(passwordController.text);
                  switch (passwordStatus) {
                    case PasswordCheck.missing8Character:
                      setState(() {
                        passwordErrorText = "Password less than 8 characters";
                      });
                      break;
                    case PasswordCheck.missingAtleastOneUppercase:
                      setState(() {
                        passwordErrorText =
                            "Password must have atleast 1 uppercase letter";
                      });
                      break;
                    case PasswordCheck.missingLowercase:
                      setState(() {
                        passwordErrorText =
                            "Password must have atleast 1 lowercase letter";
                      });
                      break;
                    case PasswordCheck.missingASymbol:
                      setState(() {
                        passwordErrorText =
                            "Password must have atleast a symbol";
                      });
                      break;
                    case PasswordCheck.missingANumber:
                      setState(() {
                        passwordErrorText =
                            "Password must have atleast a number";
                      });
                      break;
                    default:
                      setState(() {
                        passwordErrorText = null;
                        rePasswordErrorText = null;
                      });

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return const ProfileMakingScreen();
                          },
                        ),
                      );
                      break;
                  }
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
