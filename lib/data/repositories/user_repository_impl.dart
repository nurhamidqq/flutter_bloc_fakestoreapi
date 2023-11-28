import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_fakestoreapi/core/errors/server_exception.dart';
import 'package:flutter_bloc_fakestoreapi/core/errors/server_failure.dart';
import 'package:flutter_bloc_fakestoreapi/data/datasources/user_data_source.dart';
import 'package:flutter_bloc_fakestoreapi/domain/entities/users.dart';
import 'package:flutter_bloc_fakestoreapi/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource userDataSource;
  UserRepositoryImpl(this.userDataSource);

  @override
  Future<Either<ServerFailure, String>> login(
      String username, String password) async {
    try {
      final result = await userDataSource.userLogin(username, password);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, UserEntity>> userDetail(String id) async {
    try {
      final result = await userDataSource.userDetail(id);
      final user = result.toEntity();
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
