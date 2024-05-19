import 'package:firebase_auth/firebase_auth.dart';
import 'package:kizu/auth/business/repository/user_repository.dart';

class CreatingOAuthCred {
  final UserRepository userRepository;

  CreatingOAuthCred({required this.userRepository});

  Future<OAuthCredential> call() async {
    return await userRepository.creatingOAuthCredential();
  }
}
