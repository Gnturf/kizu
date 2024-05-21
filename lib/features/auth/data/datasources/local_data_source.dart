import 'dart:convert';

import 'package:kizu/core/errors/exception.dart';
import 'package:kizu/features/auth/business/entity/user_entity.dart';
import 'package:kizu/features/auth/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const storedUser = 'STORED_USER';

abstract class UserLocalDataSources {
  Future<UserEntity> getUser();
  Future<void>? storeUser(UserModel userModel);
  Future<bool> cleanUser();
}

class UserLocalDataSourcesImpl extends UserLocalDataSources {
  final SharedPreferences sharedPreferences;

  UserLocalDataSourcesImpl({
    required this.sharedPreferences,
  });

  @override
  Future<UserEntity> getUser() async {
    final jsonString = sharedPreferences.getString(storedUser);

    if (jsonString != null) {
      return Future.value(
        UserModel.fromJson(
          json.decode(jsonString),
        ),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void>? storeUser(UserModel? userModel) async {
    if (userModel != null) {
      await sharedPreferences.setString(
        storedUser,
        json.encode(userModel),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<bool> cleanUser() async {
    try {
      return await sharedPreferences.remove(storedUser);
    } catch (e) {
      throw CacheException();
    }
  }
}
