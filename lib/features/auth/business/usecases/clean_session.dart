import 'package:kizu/features/auth/business/repository/user_repository.dart';

class CleanSession {
  UserRepository repository;

  CleanSession({required this.repository});

  Future<void> call() async {
    return await repository.cleanSession();
  }
}
