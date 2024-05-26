import 'package:kizu/core/entity/user_entity.dart';

abstract class LocalUserDataSource {
  Future<UserEntity> fetchUser();
  Future<void> cachedUser(UserEntity userEntity);
  Future<void> cleanCachedUser();
}
