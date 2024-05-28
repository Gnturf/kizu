import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  test('Test GET /contacts', () async {
    final url = Uri.parse('http://localhost:5000/contacts');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer adminTest',
      },
    );

    // Check if the status code is 200 (OK)
    expect(response.statusCode, 200);

    // Optionally, check the response body
    final decodeData = jsonDecode(response.body)["data"];
    print('Decoded data: $decodeData');

    // Cast 'decodeData' to List<Map<String, dynamic>>
    final List<Map<String, dynamic>> contacts = (decodeData as List)
        .map((item) => item as Map<String, dynamic>)
        .toList();
    print('Response data: $contacts');

    // You can also add more expectations based on the expected response
    expect(contacts, isNotEmpty); // Example: Check if the data is not empty
  });
}
