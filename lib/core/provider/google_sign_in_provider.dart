import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

final googleSignInProvider =
    StateProvider<GoogleSignIn>((ref) => GoogleSignIn());
