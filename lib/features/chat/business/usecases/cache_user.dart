import 'package:dartz/dartz.dart';
import 'package:kizu/core/errors/failure.dart';
import 'package:kizu/features/chat/business/entity/user_entity.dart';
import 'package:kizu/features/chat/business/repository/user_repository.dart';

class CacheUser {
  UserRepository userRepository;

  CacheUser({required this.userRepository});

  Future<Either<Failure, void>> call(UserEntity user) async {
    return await userRepository.cacheUser(user);
  }
}
