import 'dart:convert';

import 'package:app/features/auth/data/models/user_model.dart';

import '../../../../core/exceptions/exceptions.dart';
import 'package:http/http.dart' as http;

import '../../../../core/strings/constants.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> signInUser(UserModel userModel);
  Future<void> signOutUser();
}

class UserRemoteDataSourceImpl extends UserRemoteDataSource {
  final http.Client client;
  UserRemoteDataSourceImpl({required this.client});
  @override
  Future<UserModel> signInUser(UserModel userModel) async {
    final body = jsonEncode(
        {"username": userModel.username, "password": userModel.password});
    late final response;
    try {
      // badel bel lient mte3i
      response = await client.post(Uri.parse(BASE_URL + "/auth/signin/"),
          headers: {
            "content-type": "application/json",
            "accept": "application/json",
          },
          body: body);
    } catch (e) {
      print("exception " + e.toString());
    }
    if (response.statusCode == 200) {
      try {
        final user = UserModel.fromJson(jsonDecode(response.body));
        return Future.value(user);
      } catch (e) {
        return Future.value(null);
      }
    } else {
      throw LoginException();
    }
  }

  @override
  Future<void> signOutUser() {
// TODO: implement signOutUser
    throw UnimplementedError();
  }
}
