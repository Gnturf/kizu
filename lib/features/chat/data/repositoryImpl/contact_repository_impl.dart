import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kizu/core/errors/failure.dart';
import 'package:kizu/features/chat/business/entity/contact_entity.dart';
import 'package:kizu/features/chat/business/repository/contact_repository.dart';
import 'package:kizu/features/chat/data/datasources/remote_contact_data_source.dart';

class ContactRepositoryImpl implements ContactRepository {
  RemoteContactDataSource remoteContactDataSource;

  ContactRepositoryImpl({required this.remoteContactDataSource});

  @override
  Future<Either<Failure, List<ContactEntity>>> fetchAllUserContact() async {
    try {
      /// Get the id token
      final currentUserFirebaseAuth = FirebaseAuth.instance.currentUser;
      if (currentUserFirebaseAuth == null) {
        return Left(
            SystemFailure(errorMessage: "Firebase Auth current user was null"));
      }

      final idToken = await currentUserFirebaseAuth.getIdToken();
      if (idToken == null) {
        return Left(ServerFailure(errorMessage: "ID Token was null"));
      }

      return Right(await remoteContactDataSource.fetchAllContact(idToken));
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
