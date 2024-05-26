import 'package:dartz/dartz.dart';
import 'package:kizu/core/errors/failure.dart';
import 'package:kizu/core/params/user_params.dart';
import 'package:kizu/core/entity/user_entity.dart';
import 'package:kizu/features/auth/business/repository/user_repository.dart';

class RegisterToRemote {
  AuthUserRepository repository;

  RegisterToRemote({required this.repository});

  Future<Either<Failure, UserEntity>> call(UserParams userParams) async {
    return await repository.registerToRemote(userParams: userParams);
  }
}
