import 'package:dartz/dartz.dart';
import 'package:kizu/core/errors/failure.dart';
import 'package:kizu/core/entity/user_entity.dart';
import 'package:kizu/features/chat/business/repository/user_repository.dart';

class FetchUser {
  ChatUserRepository repository;

  FetchUser({required this.repository});

  Future<Either<Failure, UserEntity>> call() async {
    return await repository.fetchUser();
  }
}
