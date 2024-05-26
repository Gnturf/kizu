import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kizu/core/errors/exception.dart';

abstract class FirebaseUserAuthDataSource {
  Future<OAuthCredential> createOAuthCredential();
  Future<UserCredential> registerOrSignInToFirebase({
    required OAuthCredential oAuthCredential,
  });
  Future<void> cleanSession();
  String getUserEmail();
}

class FirebaseDataSourceImpl implements FirebaseUserAuthDataSource {
  final GoogleSignIn googleSignIn;

  FirebaseDataSourceImpl({required this.googleSignIn});

  @override
  Future<OAuthCredential> createOAuthCredential() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return credential;
    } on FirebaseAuthException catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> cleanSession() async {
    try {
      if (googleSignIn.currentUser != null) {
        await googleSignIn.disconnect();
      }
    } on FirebaseAuthException catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  String getUserEmail() {
    if (googleSignIn.currentUser == null) {
      throw SystemException(message: "GoogleSignIn.currentUser was null");
    }

    return googleSignIn.currentUser!.email;
  }

  @override
  Future<UserCredential> registerOrSignInToFirebase({
    required OAuthCredential oAuthCredential,
  }) async {
    try {
      return await FirebaseAuth.instance.signInWithCredential(oAuthCredential);
    } on FirebaseAuthException catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
