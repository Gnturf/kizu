import 'package:kizu/auth/business/repository/user_repository.dart';

class CleaningSession {
  final UserRepository userRepository;

  CleaningSession({required this.userRepository});

  Future<void> call() async {
    await userRepository.cleanSession();
  }
}
