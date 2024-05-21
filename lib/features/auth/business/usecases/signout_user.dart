import 'package:dartz/dartz.dart';
import 'package:kizu/core/errors/failure.dart';
import 'package:kizu/features/auth/business/repository/user_repository.dart';

class SignOutUser {
  final UserRepository userRepository;

  SignOutUser({required this.userRepository});

  Future<Either<Failure, void>> call() async {
    return await userRepository.signOutUser();
  }
}
