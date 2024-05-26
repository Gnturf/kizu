import 'package:dartz/dartz.dart';
import 'package:kizu/core/errors/failure.dart';
import 'package:kizu/features/chat/business/repository/user_repository.dart';

class SignOut {
  ChatUserRepository repository;

  SignOut({required this.repository});

  Future<Either<Failure, void>> call() async {
    return await repository.signOut();
  }
}
