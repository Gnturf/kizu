import 'package:dartz/dartz.dart';
import 'package:kizu/core/errors/failure.dart';
import 'package:kizu/features/chat/business/entity/user_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> fetchUser();
  Future<Either<Failure, void>> cacheUser(UserEntity user);
  Future<void> cleanCachedUser();
}
