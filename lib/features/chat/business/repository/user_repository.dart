import 'package:dartz/dartz.dart';
import 'package:kizu/core/errors/failure.dart';
import 'package:kizu/core/entity/user_entity.dart';

abstract class ChatUserRepository {
  Future<Either<Failure, void>> cachedUser(UserEntity userEntity);
  Future<Either<Failure, UserEntity>> fetchUser();
  Future<Either<Failure, void>> signOut();
}
