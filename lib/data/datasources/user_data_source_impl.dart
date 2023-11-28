import 'dart:convert';

import 'package:flutter_bloc_fakestoreapi/core/errors/server_exception.dart';
import 'package:flutter_bloc_fakestoreapi/data/datasources/user_data_source.dart';
import 'package:flutter_bloc_fakestoreapi/data/models/user.dart';
import 'package:http/http.dart' as http;

class UserDataSourceImpl implements UserDataSource {
  final http.Client client;
  UserDataSourceImpl(this.client);

  // ignore: constant_identifier_names
  static const BASE_URL = 'https://fakestoreapi.com';

  @override
  Future<UserModel> userDetail(String id) async {
    final response = await client.get(Uri.parse("$BASE_URL/users/$id"));
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final UserModel user = UserModel.fromJson(responseBody);
      return user;
    } else {
      return exceptionHandling(response);
    }
  }

  @override
  Future<String> userLogin(String username, String password) async {
    Map body = {'username': username, 'password': password};
    final encodeBody = jsonEncode(body);
    final response = await client.post(
      Uri.parse("$BASE_URL/auth/login"),
      body: encodeBody,
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return responseBody['token'];
    } else {
      return exceptionHandling(response);
    }
  }
}
