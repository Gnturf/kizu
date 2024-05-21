import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kizu/features/auth/presentation/components/icon_text_button.dart';
import 'package:kizu/features/auth/presentation/components/snackbar/custom_snack_bar.dart';
import 'package:kizu/features/auth/presentation/provider/user_provider.dart';

// ignore: must_be_immutable
class TempChat extends ConsumerStatefulWidget {
  const TempChat({super.key});

  @override
  ConsumerState<TempChat> createState() => _TempChatState();
}

class _TempChatState extends ConsumerState<TempChat> {
  String idToken = "";
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final userData = ref.watch(userProvider).user;

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Card(
              color: Colors.black,
              child: Column(
                children: [
                  Text(userData!.displayName),
                  Text(userData.email),
                  Text(userData.statusMessage ?? ""),
                  Text(userData.contactID ?? ""),
                  SelectableText(idToken)
                ],
              ),
            ),
            IconTextButton(
              label: "Get ID Token",
              onPressed: () async {
                User? user = FirebaseAuth.instance.currentUser;
                if (user != null) {
                  final userToken = await user.getIdToken();
                  setState(() {
                    idToken = userToken ?? "";
                  });

                  print(userToken);
                } else {
                  throw Exception('User not signed in');
                }
              },
            ),
            IconTextButton.inverted(
              isLoading: isLoading,
              label: "Sign Out",
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                final failureOrSignOut =
                    await ref.watch(userProvider).signOutUser();
                setState(() {
                  isLoading = false;
                });

                // Check if signOut was success
                failureOrSignOut.fold(
                  (newFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      customSnackBar(
                          context, newFailure.toString(), Colors.red),
                    );
                  },
                  (success) => null,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
