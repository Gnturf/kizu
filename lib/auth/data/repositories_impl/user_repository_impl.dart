import 'package:firebase_auth_platform_interface/src/providers/oauth.dart';
import 'package:kizu/auth/business/entity/user_entity.dart';
import 'package:kizu/auth/data/datasources/firebase_data_source.dart';
import 'package:kizu/auth/data/models/user_params.dart';
import 'package:kizu/auth/business/repository/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final FirebaseDataSource firebaseDataSource;

  UserRepositoryImpl({
    required this.firebaseDataSource,
  });

  @override
  Future<UserEntity> registerUser({
    required UserParams user,
    required OAuthCredential oAuthCredential,
  }) async {
    final gUserCredential =
        await firebaseDataSource.registerToFirebase(oAuthCredential);
    return UserEntity(
      displayName: gUserCredential.user!.email!,
      email: gUserCredential.user!.email!,
    );
  }

  @override
  Future<OAuthCredential> creatingOAuthCredential() async {
    return await firebaseDataSource.creatingGoogleOAuthCred();
  }

  @override
  Future<void> cleanSession() async {
    await firebaseDataSource.cleanCurrentSession();
  }
}
