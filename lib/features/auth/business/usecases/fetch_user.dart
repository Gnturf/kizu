import 'package:dartz/dartz.dart';
import 'package:kizu/core/errors/failure.dart';
import 'package:kizu/features/auth/business/entity/user_entity.dart';
import 'package:kizu/features/auth/business/repository/user_repository.dart';

class FetchUser {
  UserRepository repository;

  FetchUser({required this.repository});

  Future<Either<Failure, UserEntity>> call() async {
    return await repository.fetchUser();
  }
}
