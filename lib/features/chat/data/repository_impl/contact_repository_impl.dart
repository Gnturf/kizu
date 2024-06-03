import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kizu/core/errors/failure.dart';
import 'package:kizu/features/chat/business/entity/contact_entity.dart';
import 'package:kizu/features/chat/business/repository/contact_repository.dart';
import 'package:kizu/features/chat/data/datasources/remote_contact_data_source.dart';

class ContactRepositoryImpl extends ContactRepository {
  RemoteContactDataSource remoteContactDataSource;

  ContactRepositoryImpl({required this.remoteContactDataSource});

  @override
  Future<Either<Failure, List<ContactEntity>>> fetchContact() async {
    try {
      final fAuthCurrentUser = FirebaseAuth.instance.currentUser;
      if (fAuthCurrentUser == null) {
        return Left(
            SystemFailure(errorMessage: "FirebaseAuth current user was null"));
      }

      final idToken = await fAuthCurrentUser.getIdToken();
      if (idToken == null) {
        return Left(
            SystemFailure(errorMessage: "FirebaseAuth ID Token was null"));
      }

      return Right(await remoteContactDataSource.fetchContact(idToken));
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
