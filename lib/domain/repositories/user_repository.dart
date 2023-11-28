import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_fakestoreapi/core/errors/server_failure.dart';
import 'package:flutter_bloc_fakestoreapi/domain/entities/users.dart';

abstract class UserRepository {
  Future<Either<ServerFailure, String>> login(String username, String password);
  Future<Either<ServerFailure, UserEntity>> userDetail(String id);
}
