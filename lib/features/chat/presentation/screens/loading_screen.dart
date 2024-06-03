import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kizu/core/errors/failure.dart';
import 'package:kizu/features/auth/presentation/provider/auth_mode_provider.dart';
import 'package:kizu/features/chat/business/entity/contact_entity.dart';
import 'package:kizu/features/chat/business/entity/user_entity.dart';
import 'package:kizu/features/chat/presentation/provider/contact_provider.dart';
import 'package:kizu/features/chat/presentation/provider/user_provider.dart';

class LoadingScreen extends ConsumerStatefulWidget {
  const LoadingScreen({super.key});

  @override
  ConsumerState<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends ConsumerState<LoadingScreen> {
  Failure? failure;

  @override
  void initState() {
    _initFetch();
    super.initState();
  }

  void _initFetch() async {
    final fetchUser = await ref.read(userProvider).fetchUser();
    fetchUser.fold(
      (newFailure) {
        failure = newFailure;
        return;
      },
      (newUser) async {
        _tryFetchContacts(newUser);
      },
    );
  }

  Future<void> _tryFetchContacts(UserEntity newUser) async {
    final fetchContact = await ref.read(contactProvider).fetchContacts();
    fetchContact.fold(
      (newFailure) {
        failure = newFailure;
      },
      (newContactList) {
        _cacheAndNavigate(newUser, newContactList);
      },
    );
  }

  Future<void> _cacheAndNavigate(
      UserEntity newUser, List<ContactEntity> newContactList) async {
    ref.read(authModeProvider).setAuthMode(AuthMode.none);

    final cacheUser = await ref.read(userProvider).cacheUser(newUser);
    // TODO: Implements Contact Storing
    cacheUser.fold(
      (newFailure) {
        failure = newFailure;
      },
      (_) {
        if (!mounted) return;
        Navigator.of(context).popUntil((route) => route.isFirst);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          padding: const EdgeInsets.symmetric(vertical: 32),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: failure != null
                ? [
                    const Text("Something goes wrong"),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(failure!.errorMessage),
                  ]
                : [
                    const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("Loading"),
                  ],
          ),
        ),
      ),
    );
  }
}
