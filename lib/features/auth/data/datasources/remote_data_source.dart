import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:kizu/core/errors/exception.dart';
import 'package:kizu/features/auth/data/models/user_model.dart';
import 'package:http/http.dart' as http;

abstract class RemoteUserDataSource {
  Future<void> registerToRemote(UserModel userModel, String idToken);
  Future<bool> isUserExist(String email);
}

class RemoteDataSourceImpl implements RemoteUserDataSource {
  final String domain;

  RemoteDataSourceImpl({required this.domain});

  @override
  Future<void> registerToRemote(UserModel userModel, String idToken) async {
    try {
      var uri = Uri.http('$domain:5000', '/user');

      var reqBody = json.encode({
        "uid": userModel.uid,
        "displayName": userModel.displayName,
        "email": userModel.email,
        "password": userModel.password
      });

      var response = await http
          .post(
            uri,
            headers: {
              "Content-Type": "application/json",
              "authorization": "Bearer $idToken"
            },
            body: reqBody,
          )
          .timeout(const Duration(seconds: 20));

      final Map<String, dynamic> decodedBody = json.decode(response.body);

      if (response.statusCode == 400 || decodedBody["status"] == "failed") {
        throw ServerException(message: decodedBody["message"]);
      }
    } on SocketException {
      throw ServerException(message: "No Internet connection.");
    } on TimeoutException {
      throw ServerException(
          message: "Server could not be reached, please try again.");
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<bool> isUserExist(String email) async {
    try {
      var uri = Uri.http('$domain:5000', '/user/checkEmail/');

      var reqBody = json.encode({
        "email": email,
      });

      var response = await http
          .post(
            uri,
            headers: {
              "Content-Type": "application/json",
            },
            body: reqBody,
          )
          .timeout(const Duration(seconds: 20));

      final Map<String, dynamic> decodedBody = json.decode(response.body);

      print('${response.statusCode}, ${response.body}');

      if (response.statusCode == 400 || decodedBody["status"] == "failed") {
        return false;
      }

      return true;
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
