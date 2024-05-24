import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  test('Make a network request', () async {
    final idToken = await FirebaseAuth.instance.currentUser!.getIdToken();

    var uri = Uri.http('localhost:5000', '/user');

    var reqBody = json.encode({
      "uid": "glMOnvECN5XUM08hEPb7bkmXa1C3",
      "displayName": "Guntur Firmansyah",
      "email": "shirouneko19@gmail.com",
      "password": "boardmaker19"
    });

    var response = await http.get(
      uri,
      headers: {
        "Content-Type": "application/json",
        "authorization":
            "Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6IjNjOTNjMWEyNGNhZjgyN2I4ZGRlOWY4MmQyMzE1MzY1MDg4YWU2MTIiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiU2hpcm91IE5la28iLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jS0t6SHlQSGVERmktT2NDMHdtSzI2bHo0eTZuQ0VleXJ1d3hoTEtfR2hpbFZZQTNRPXM5Ni1jIiwiaXNzIjoiaHR0cHM6Ly9zZWN1cmV0b2tlbi5nb29nbGUuY29tL2tpenUtOTdjNTYiLCJhdWQiOiJraXp1LTk3YzU2IiwiYXV0aF90aW1lIjoxNzE2Mjc3MTQ1LCJ1c2VyX2lkIjoiZ2xNT252RUNONVhVTTA4aEVQYjdia21YYTFDMyIsInN1YiI6ImdsTU9udkVDTjVYVU0wOGhFUGI3YmttWGExQzMiLCJpYXQiOjE3MTYyNzcxNDUsImV4cCI6MTcxNjI4MDc0NSwiZW1haWwiOiJzaGlyb3VuZWtvMTlAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnsiZ29vZ2xlLmNvbSI6WyIxMTI4ODk5NTAzNDY4NTY4MTczMTAiXSwiZW1haWwiOlsic2hpcm91bmVrbzE5QGdtYWlsLmNvbSJdfSwic2lnbl9pbl9wcm92aWRlciI6Imdvb2dsZS5jb20ifX0.DkLOPUnTMzuBpYBMajCnEyB_cEwaBZUTzj4SQBBiSIqjXHlyDWkehSBvAl3IM26ZS0tcxOZidsw92kQMYfqMYWFe-U-8O8xJiDN1BsrBX29obdX69GrQIezMnFdmjLLga2-l19aAETyoxV9OSlw1aI7kMzoQ5UffjQLOqYUlFPI4oEeOjiRS_FtNRdXT_nrBq0o9qVoCtYzSUliiOO2EdLZk1V7-GutxJtZkCVX2qaUP2ZdsG36yQwNeXoc40tJv4iUAK36JJsXDNQS5_s-kTV2uJ7LldS-ueb8MJYxiFNFIXPr_9oL5fKgjRecnHjhc9HQBqPoj5naUJa2gYbaJOg"
      },
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${json.decode(response.body)}');
  });
}
