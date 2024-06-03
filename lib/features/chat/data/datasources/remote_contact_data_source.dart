import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:kizu/core/errors/exception.dart';
import 'package:kizu/features/chat/business/entity/contact_entity.dart';
import 'package:http/http.dart' as http;
import 'package:kizu/features/chat/data/model/contact_model.dart';

abstract class RemoteContactDataSource {
  Future<List<ContactEntity>> fetchContact(String idToken);
}

class RemoteContractDataSourceImpl implements RemoteContactDataSource {
  final String domain;

  RemoteContractDataSourceImpl({required this.domain});

  @override
  Future<List<ContactEntity>> fetchContact(String idToken) async {
    try {
      var uri = Uri.http('$domain:5000', '/contacts');

      var response = await http.get(
        uri,
        headers: {
          "Content-Type": "application/json",
          "authorization": "Bearer $idToken"
        },
      ).timeout(const Duration(seconds: 20));

      final Map<String, dynamic> decodedBody =
          json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 400 || decodedBody["status"] == "failed") {
        throw ServerException(message: decodedBody["message"]);
      }

      final decodeData = jsonDecode(response.body)["data"];
      print('Decoded data: $decodeData');

      final List<ContactEntity> contacts = (decodeData as List)
          .map(
            (contact) => ContactModel.fromJson(contact),
          )
          .toList();
      print(contacts.length);

      return contacts;
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
