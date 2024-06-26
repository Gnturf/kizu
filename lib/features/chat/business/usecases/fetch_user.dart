import 'package:dartz/dartz.dart';
import 'package:kizu/core/errors/failure.dart';
import 'package:kizu/features/chat/business/entity/user_entity.dart';
import 'package:kizu/features/chat/business/repository/user_repository.dart';

class FetchUser {
  UserRepository userRepository;

  FetchUser({required this.userRepository});

  Future<Either<Failure, UserEntity>> call() async {
    return await userRepository.fetchUser();
  }
}
