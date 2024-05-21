import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kizu/core/errors/exception.dart';
import 'package:kizu/core/errors/failure.dart';

class FirebaseDataSource {
  final GoogleSignIn googleSignIn;

  FirebaseDataSource({required this.googleSignIn});

  Future<UserCredential> registerToFirebase() async {
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

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (error) {
      throw ServerException(message: error.message!);
    }
  }

  Future<void> cleanCurrentSession() async {
    if (googleSignIn.currentUser != null) {
      await googleSignIn.disconnect();
    }
  }

  Future<void> signOutWithGoogle() async {
    try {
      await googleSignIn.disconnect();
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (error) {
      throw ServerFailure(errorMessage: error.message!);
    }
  }
}
