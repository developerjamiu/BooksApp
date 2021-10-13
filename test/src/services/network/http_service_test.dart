import 'dart:convert';

import 'package:books/src/services/base/api.dart';
import 'package:books/src/services/base/failure.dart';
import 'package:books/src/services/network/http_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

final API api = API();

final client = MockClient((request) async {
  if (request.url == api.baseUri()) {
    return Response(json.encode({"data": "success"}), 200);
  } else {
    throw Failure('failed');
  }
});

void main() {
  final networkService = HttpService(client: client);

  test('Should return success when GET request is successful', () async {
    final response = await networkService.get(API().baseUri());

    expect(response, {"data": "success"});
  });

  test('Should return error when GET request is not successful', () async {
    final response = networkService.get(API().errorUri());

    expect(response, throwsA(isA<Failure>()));
  });
}
