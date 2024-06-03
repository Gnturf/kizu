import 'package:dartz/dartz.dart';
import 'package:kizu/core/errors/failure.dart';
import 'package:kizu/core/params/user_params.dart';
import 'package:kizu/features/auth/business/repository/auth_repository.dart';

class RegisterToRemote {
  AuthRepository repository;

  RegisterToRemote({required this.repository});

  Future<Either<Failure, void>> call(UserParams userParams) async {
    return await repository.registerToRemote(userParams: userParams);
  }
}
