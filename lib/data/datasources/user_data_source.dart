import 'package:flutter_bloc_fakestoreapi/data/models/user.dart';

abstract class UserDataSource {
  Future<String> userLogin(String username, String password);
  Future<UserModel> userDetail(String id);
}
