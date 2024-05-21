import 'package:dartz/dartz.dart';
import 'package:kizu/core/errors/failure.dart';
import 'package:kizu/features/auth/business/repository/user_repository.dart';

import '../entity/user_entity.dart';

class GetUser {
  final UserRepository userRepository;

  GetUser({required this.userRepository});

  Future<Either<Failure, UserEntity>> call() async {
    return await userRepository.getUser();
  }
}
