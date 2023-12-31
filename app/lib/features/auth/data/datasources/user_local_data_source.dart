import 'dart:convert';

import 'package:app/features/auth/data/models/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/exceptions/exceptions.dart';
import '../../../../core/strings/constants.dart';

abstract class UserLocalDataSource {
  Future<UserModel> getCachedUser();
  Future<Unit> cacheUser(UserModel user);
  Future<Unit> clearCachedUser();
}

class UserLocalDataSourceImpl extends UserLocalDataSource {
  final SharedPreferences sharedPreferences;
  UserLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<Unit> cacheUser(UserModel user) {
    sharedPreferences.setString(CACHED_USER, json.encode(user.toJson()));
    return Future.value(unit);
  }

  @override
  Future<UserModel> getCachedUser() {
    final userJsonString = sharedPreferences.getString(CACHED_USER);
    if (userJsonString != null) {
      UserModel user = UserModel.fromJson(json.decode(userJsonString));
      return Future.value(user);
    } else {
      throw EmptyCacheException();
    }
  }

  @override
  Future<Unit> clearCachedUser() {
    sharedPreferences.remove(CACHED_USER);
    return Future.value(unit);
  }
}
