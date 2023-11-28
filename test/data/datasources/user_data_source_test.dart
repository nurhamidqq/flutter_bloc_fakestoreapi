import 'dart:convert';

import 'package:flutter_bloc_fakestoreapi/core/errors/server_exception.dart';
import 'package:flutter_bloc_fakestoreapi/data/datasources/user_data_source_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import 'mock_client.mocks.dart';

void main() {
  late UserDataSourceImpl dataSource;
  late MockClient mockClient;

  // ignore: constant_identifier_names
  const tBASE_URL = "https://fakestoreapi.com";
  const tIdUser = '2';
  const tUsername = 'mor_2314';
  const tPassword = '83r5^_';
  const Map loginBody = {'username': tUsername, 'password': tPassword};
  const sampleLogin = '''{
    "token": "sampletoken"
  }''';
  const sampleResponse = '''{
    "address": {
        "geolocation": {
            "lat": "-37.3159",
            "long": "81.1496"
        },
        "city": "kilcoole",
        "street": "Lovers Ln",
        "number": 7267,
        "zipcode": "12926-3874"
    },
    "id": 2,
    "email": "morrison@gmail.com",
    "username": "mor_2314",
    "password": "83r5^_",
    "name": {
        "firstname": "david",
        "lastname": "morrison"
    },
    "phone": "1-570-236-7033",
    "__v": 0
}''';

  setUp(() async {
    mockClient = MockClient();
    dataSource = UserDataSourceImpl(mockClient);
  });

  test("get request on a url to get user detail", () async {
    when(mockClient.get(Uri.parse("$tBASE_URL/users/$tIdUser")))
        .thenAnswer((_) async => http.Response(sampleResponse, 200));
    await dataSource.userDetail(tIdUser);
    verify(mockClient.get(Uri.parse("$tBASE_URL/users/$tIdUser")));
  });

  test('post request on a url to user login', () async {
    when(mockClient.post(
      Uri.parse("$tBASE_URL/auth/login"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(loginBody),
    )).thenAnswer((_) async => http.Response(sampleLogin, 200));

    final result = await dataSource.userLogin(tUsername, tPassword);

    expect(result, 'sampletoken');

    verify(mockClient.post(
      Uri.parse("$tBASE_URL/auth/login"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(loginBody),
    ));
  });

  test('throw a ServerException', () async {
    when(mockClient.get(any))
        .thenAnswer((_) async => http.Response('Error', 404));

    final call = dataSource.userDetail;

    expect(() => call(tIdUser), throwsA(isA<ServerException>()));
  });
}
