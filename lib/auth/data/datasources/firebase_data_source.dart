import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseDataSource {
  final GoogleSignIn googleSignIn;

  FirebaseDataSource({required this.googleSignIn});

  Future<OAuthCredential> creatingGoogleOAuthCred() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    return GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
  }

  Future<UserCredential> registerToFirebase(OAuthCredential credential) async {
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> cleanCurrentSession() async {
    if (googleSignIn.currentUser != null) {
      await googleSignIn.disconnect();
    }
  }

  Future<void> signOutWithGoogle() async {
    await googleSignIn.disconnect();
    await FirebaseAuth.instance.signOut();
  }
}
