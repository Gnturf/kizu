import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:kizu/core/errors/exception.dart';
import 'package:kizu/features/chat/data/model/contact_model.dart';
import 'package:http/http.dart' as http;

abstract class RemoteContactDataSource {
  Future<List<ContactModel>> fetchAllContact(String idToken);
}

class RemoteContactDataSourceImpl implements RemoteContactDataSource {
  final String domain;

  RemoteContactDataSourceImpl({required this.domain});

  @override
  Future<List<ContactModel>> fetchAllContact(String idToken) async {
    try {
      var uri = Uri.http('$domain:5000', '/contacts');

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

      final data = decodedBody["data"] as List<dynamic>;

      final List<ContactModel> contactList =
          data.map((contact) => ContactModel.fromJson(contact)).toList();

      return contactList;
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
