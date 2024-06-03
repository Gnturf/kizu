import 'dart:convert';

import 'package:kizu/core/errors/exception.dart';
import 'package:kizu/features/chat/business/entity/user_entity.dart';
import 'package:kizu/features/chat/data/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const storedUser = 'STORED_USER';

abstract class LocalUserDataSource {
  Future<UserEntity> fetchUser();
  Future<void> cachedUser(UserEntity userEntity);
  Future<void> cleanCachedUser();
}

class LocalUserDataSourcesImpl implements LocalUserDataSource {
  final SharedPreferences sharedPreferences;

  LocalUserDataSourcesImpl({
    required this.sharedPreferences,
  });

  @override
  Future<UserEntity> fetchUser() async {
    final jsonString = sharedPreferences.getString(storedUser);

    if (jsonString != null) {
      return Future.value(
        UserModel.fromJson(
          json.decode(jsonString),
        ),
      );
    } else {
      throw CacheException(message: 'Local Not Found');
    }
  }

  @override
  Future<void> cachedUser(UserEntity userEntity) async {
    try {
      await sharedPreferences.setString(
        storedUser,
        json.encode(userEntity),
      );
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> cleanCachedUser() async {
    try {
      await sharedPreferences.remove(storedUser);
    } catch (e) {
      throw CacheException();
    }
  }
}
