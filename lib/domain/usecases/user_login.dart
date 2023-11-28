import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_fakestoreapi/core/errors/server_failure.dart';
import 'package:flutter_bloc_fakestoreapi/domain/repositories/user_repository.dart';

class UserLogin {
  final UserRepository userRepository;
  UserLogin(this.userRepository);

  Future<Either<ServerFailure, String>> call(
      String username, String password) async {
    return await userRepository.login(username, password);
  }
}
