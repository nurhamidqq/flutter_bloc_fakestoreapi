part of 'user_login_bloc.dart';

abstract class UserLoginState {}

class UserLoginInitial extends UserLoginState {}

class UserLoginLoading extends UserLoginState {}

class UserLoginDone extends UserLoginState {
  final String token;
  UserLoginDone(this.token);
}

class UserLoginError extends UserLoginState {
  final String message;
  UserLoginError(this.message);
}
