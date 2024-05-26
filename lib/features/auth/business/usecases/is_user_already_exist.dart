import 'package:dartz/dartz.dart';
import 'package:kizu/core/errors/failure.dart';
import 'package:kizu/features/auth/business/repository/user_repository.dart';

class IsUserAlreadyExist {
  AuthUserRepository repository;

  IsUserAlreadyExist({required this.repository});

  Future<Either<Failure, bool>> call() async {
    return await repository.isUserAlreadyExist();
  }
}
