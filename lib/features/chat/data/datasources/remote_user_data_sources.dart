import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:kizu/core/errors/exception.dart';
import 'package:kizu/features/auth/data/models/user_model.dart';
import 'package:http/http.dart' as http;

abstract class RemoteUserDataSource {
  Future<UserModel> getUser(String idToken);
}

class RemoteUserDataSourceImpl implements RemoteUserDataSource {
  final String domain;

  RemoteUserDataSourceImpl({required this.domain});

  @override
  Future<UserModel> getUser(String idToken) async {
    try {
      var uri = Uri.http('$domain:5000', '/user');

      var response = await http.get(
        uri,
        headers: {
          "Content-Type": "application/json",
          "authorization": "Bearer $idToken"
        },
      ).timeout(const Duration(seconds: 20));

      final Map<String, dynamic> decodedBody = json.decode(response.body);

      if (response.statusCode == 400 || decodedBody["status"] == "failed") {
        throw ServerException(message: decodedBody["message"]);
      }

      return UserModel.fromJson(decodedBody["data"]);
    } on SocketException {
      throw ServerException(message: "No Internet connection.");
    } on TimeoutException {
      throw ServerException(
          message: "Server could not be reached, please try again.");
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
