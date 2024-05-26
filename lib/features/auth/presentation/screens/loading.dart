import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kizu/core/errors/failure.dart';
import 'package:kizu/core/entity/user_entity.dart';
import 'package:kizu/features/auth/presentation/components/snackbar/custom_snack_bar.dart';
import 'package:kizu/features/auth/presentation/provider/auth_mode_provider.dart';
import 'package:kizu/features/auth/presentation/provider/user_params_provider.dart';
import 'package:kizu/core/provider/user_provider.dart';

class LoadingScreen extends ConsumerStatefulWidget {
  final AuthMode authMode;

  const LoadingScreen({
    super.key,
    required this.authMode,
  });

  @override
  ConsumerState<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends ConsumerState<LoadingScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    _initTask();
    super.initState();
  }

  Future<void> signinTask() async {
    setState(() {
      _isLoading = true;
    });

    // Register user to remote
    final failureOrUserEntity = await ref.read(userProvider).fetchUser();

    if (!mounted) return;

    failureOrUserEntity.fold(
      (newFailure) {
        _handleFailure(newFailure);

        return;
      },
      (newUserEntity) async {
        // Cache User To Local
        await _cacheUserAndNavigate(newUserEntity);
      },
    );
  }

  Future<void> signupTask() async {
    setState(() {
      _isLoading = true;
    });

    final userParams = ref.read(userParamsProvider).userParams;

    // Register user to remote
    final failureOrUserEntity =
        await ref.read(userProvider).registerToRemote(userParams: userParams);

    if (!mounted) return;

    failureOrUserEntity.fold(
      (newFailure) {
        _handleFailure(newFailure);

        return;
      },
      (newUserEntity) async {
        // Cache User To Local
        await _cacheUserAndNavigate(newUserEntity);
      },
    );
  }

  void _handleFailure(Failure newFailure) {
    ScaffoldMessenger.of(context).showSnackBar(
      customSnackBar(context, newFailure.errorMessage, Colors.red),
    );

    setState(() {
      _isLoading = false;
    });
  }

  void _setLoadingState(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  Future<void> _cacheUserAndNavigate(UserEntity newUserEntity) async {
    // Cache user to local
    final failureOrCachedRemote =
        await ref.read(userProvider).cachedUser(newUserEntity);

    failureOrCachedRemote.fold(
      (newFailure) {
        _handleFailure(newFailure);

        return;
      },
      (_) {
        ref.read(authModeProvider).setAuthMode(AuthMode.none);
        _setLoadingState(false);

        // Navigate to TempChat
        Navigator.of(context).popUntil((route) => route.isFirst);
      },
    );
  }

  void _initTask() async {
    setState(() {
      _isLoading = true; // Show loading indicator
    });

    switch (widget.authMode) {
      case AuthMode.signup:
        await signupTask();
        break;
      case AuthMode.signin:
        await signinTask();
        break;
      default:
    }

    setState(() {
      _isLoading = false; // Hide loading indicator
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : const SizedBox.shrink(),
      ),
    );
  }
}
