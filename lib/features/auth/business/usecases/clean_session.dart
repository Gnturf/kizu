import 'package:kizu/features/auth/business/repository/auth_repository.dart';

class CleanSession {
  AuthRepository repository;

  CleanSession({required this.repository});

  Future<void> call() async {
    return await repository.cleanSession();
  }
}
