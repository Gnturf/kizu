import 'package:kizu/auth/business/repository/user_repository.dart';

class SignOutUser {
  final UserRepository userRepository;

  SignOutUser({required this.userRepository});

  Future<void> call() async {
    return await userRepository.signOutUser();
  }
}
