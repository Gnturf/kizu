import 'package:kizu/features/chat/business/repository/user_repository.dart';

class CleanCachedUser {
  final UserRepository userRepository;

  CleanCachedUser({required this.userRepository});

  Future<void> call() async {
    await userRepository.cleanCachedUser();
  }
}
