import 'package:dartz/dartz.dart';
import 'package:kizu/core/errors/failure.dart';
import 'package:kizu/features/auth/business/repository/auth_repository.dart';

class IsUserAlreadyExist {
  AuthRepository repository;

  IsUserAlreadyExist({required this.repository});

  Future<Either<Failure, bool>> call() async {
    return await repository.isUserAlreadyExist();
  }
}
