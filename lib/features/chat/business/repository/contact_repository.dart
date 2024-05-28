import 'package:dartz/dartz.dart';
import 'package:kizu/core/entity/user_entity.dart';
import 'package:kizu/core/errors/failure.dart';

abstract class ContactRepository {
  Future<Either<Failure, List<UserEntity>>> fetchAllUserContact();
}
