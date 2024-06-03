import 'package:dartz/dartz.dart';
import 'package:kizu/core/errors/failure.dart';
import 'package:kizu/features/chat/business/entity/contact_entity.dart';
import 'package:kizu/features/chat/business/repository/contact_repository.dart';

class FetchContact {
  ContactRepository contactRepository;

  FetchContact({required this.contactRepository});

  Future<Either<Failure, List<ContactEntity>>> call() async {
    return await contactRepository.fetchContact();
  }
}
