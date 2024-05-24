import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kizu/core/errors/failure.dart';
import 'package:kizu/features/auth/business/entity/user_entity.dart';
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
  void initState() {
    _initFetch();
    super.initState();
  }

  void _initFetch() async {
    if (ref.read(userProvider).userEntity == null) {
      final fetchResult = await ref.read(userProvider).fetchUser();

      fetchResult.fold(
        (newFailure) {
          handleFailure(newFailure);
        },
        (_) {},
      );
    }
  }

  void handleFailure(Failure newFailure) {
    ScaffoldMessenger.of(context).showSnackBar(
      customSnackBar(context, newFailure.errorMessage, Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    UserEntity? userEntity = ref.watch(userProvider).userEntity;

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Card(
              color: Colors.black,
              child: Column(
                children: userEntity == null
                    ? []
                    : [
                        Text(userEntity.uid),
                        Text(userEntity.displayName),
                        Text(userEntity.email),
                        Text(
                            userEntity.statusMessage ?? "Status Message Empty"),
                        Text(userEntity.contactID ?? "ContactID Empty"),
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

                final signOutResult = await ref.read(userProvider).signOut();
                print("Over Here");
                signOutResult.fold(
                  (newFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      customSnackBar(
                          context, newFailure.errorMessage, Colors.red),
                    );
                  },
                  (_) {},
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
