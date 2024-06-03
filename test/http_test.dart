import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:kizu/features/chat/business/entity/contact_entity.dart';
import 'package:kizu/features/chat/data/model/contact_model.dart';

void main() {
  test('Test GET /contacts', () async {
    final url = Uri.parse(
      'http://localhost:5000/contacts',
    );
    final response = await http.get(
      url,
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6IjVkNjE3N2E5Mjg2ZDI1Njg0NTI2OWEzMTM2ZDNmNjY0MjZhNGQ2NDIiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiM0lBMTVfR3VudHVyIEZpcm1hbnN5YWgiLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSVo0Mkx2NFJwRkZweXNrSmZNTlRHdUhMUUtGZG8yT2Vrd2VONDZaZjJzNzNKSElFZz1zOTYtYyIsImlzcyI6Imh0dHBzOi8vc2VjdXJldG9rZW4uZ29vZ2xlLmNvbS9raXp1LTk3YzU2IiwiYXVkIjoia2l6dS05N2M1NiIsImF1dGhfdGltZSI6MTcxNzM1MTk1NCwidXNlcl9pZCI6IjlKR3E4YWZ5b1hZTnRFVTQ3VE9KUGR4bU5adjIiLCJzdWIiOiI5SkdxOGFmeW9YWU50RVU0N1RPSlBkeG1OWnYyIiwiaWF0IjoxNzE3MzUxOTU0LCJleHAiOjE3MTczNTU1NTQsImVtYWlsIjoicmFpbnlnaG9zdDE5QGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJmaXJlYmFzZSI6eyJpZGVudGl0aWVzIjp7Imdvb2dsZS5jb20iOlsiMTE0OTAyNjE2OTMyMTgxNDQ2NjA1Il0sImVtYWlsIjpbInJhaW55Z2hvc3QxOUBnbWFpbC5jb20iXX0sInNpZ25faW5fcHJvdmlkZXIiOiJnb29nbGUuY29tIn19.d5RlmPEzDAXl01VZtSsoY78WmGmX-1sT_0scjLkkXOn3luwPh8xikOsbDxfmmGa8nnCuS2jH35Cu25kgngbuWitSrwQ41a5MWaXIEpB8syO7IDoHxwYD4yGM6fCPIaDPgJlGUK97q7hXbc61werimxnDBTXVOTRYrq54GSgx7MANxq-PmKa-wsxN9qiatnFcJLkvGFZbRyGsuruLITVlUNPqFehfRnZ0Gw7VVVklKPK2F8qmGTvTs2jo8KMRiVbq_DeQ9odpJEgBaRoD3bHVwNesesrsEiN6hkD5UUk2JE4g8FjyFugpxzh_BRdZc3ZDFpmKn6B8DsTEtv7vg1_mKQ',
      },
    );

    // Check if the status code is 200 (OK)
    expect(response.statusCode, 200);

    // Optionally, check the response body
    final decodeData = jsonDecode(response.body)["data"];
    print('Decoded data: $decodeData');

    // // Cast 'decodeData' to List<Map<String, dynamic>>
    // final List<Map<String, dynamic>> contacts = (decodeData as List)
    //     .map((item) => item as Map<String, dynamic>)
    //     .toList();
    // print('Response data: $contacts');

    // Iterate through the data list
    final List<ContactEntity> contacts = (decodeData as List)
        .map(
          (contact) => ContactModel.fromJson(contact),
        )
        .toList();

    for (var contact in contacts) {
      print(contact.uid);
      print(contact.displayName);
      print(contact.statusMessage);
      print(contact.contactID);
    }
  });
}
