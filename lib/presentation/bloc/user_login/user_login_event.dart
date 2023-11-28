part of 'user_login_bloc.dart';

abstract class UserLoginEvent {}

class FetchUserLogin extends UserLoginEvent {
  final String username;
  final String password;
  FetchUserLogin(this.username, this.password);
}
