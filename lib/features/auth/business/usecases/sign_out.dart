import 'package:dartz/dartz.dart';
import 'package:kizu/core/errors/failure.dart';
import 'package:kizu/features/auth/business/repository/user_repository.dart';

class SignOut {
  UserRepository repository;

  SignOut({required this.repository});

  Future<Either<Failure, void>> call() async {
    return await repository.signOut();
  }
}
