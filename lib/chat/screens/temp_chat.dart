import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kizu/auth/presentation/components/icon_text_button.dart';
import 'package:kizu/auth/presentation/provider/user_provider.dart';

// ignore: must_be_immutable
class TempChat extends ConsumerStatefulWidget {
  const TempChat({super.key});

  @override
  ConsumerState<TempChat> createState() => _TempChatState();
}

class _TempChatState extends ConsumerState<TempChat> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final userData = ref.watch(userProvider).user;

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(userData!.email),
            IconTextButton.inverted(
              isLoading: isLoading,
              label: "Sign Out",
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                await ref.watch(userProvider).signOutUser();
                setState(() {
                  isLoading = false;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
