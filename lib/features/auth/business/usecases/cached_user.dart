import 'package:dartz/dartz.dart';
import 'package:kizu/core/errors/failure.dart';
import 'package:kizu/core/entity/user_entity.dart';
import 'package:kizu/features/auth/business/repository/user_repository.dart';

class CachedUser {
  AuthUserRepository repository;

  CachedUser({required this.repository});

  Future<Either<Failure, void>> call(UserEntity userEntity) async {
    return await repository.cachedUser(userEntity);
  }
}
