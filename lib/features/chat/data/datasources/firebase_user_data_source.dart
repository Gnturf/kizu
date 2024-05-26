import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kizu/core/errors/exception.dart';

abstract class FirebaseUserDataSource {
  Future<void> signOut();
}

class FirebaseUserDataSourceImpl implements FirebaseUserDataSource {
  final GoogleSignIn googleSignIn;

  FirebaseUserDataSourceImpl({required this.googleSignIn});

  @override
  Future<void> signOut() async {
    try {
      await googleSignIn.disconnect();
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
