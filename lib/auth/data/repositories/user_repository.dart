import 'package:kizu/auth/data/models/user.dart';

abstract class UserRepository {
  void registerUser({required User user});
}
