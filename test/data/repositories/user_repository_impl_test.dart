import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_fakestoreapi/core/errors/server_exception.dart';
import 'package:flutter_bloc_fakestoreapi/core/errors/server_failure.dart';
import 'package:flutter_bloc_fakestoreapi/data/models/user.dart';
import 'package:flutter_bloc_fakestoreapi/data/repositories/user_repository_impl.dart';
import 'package:flutter_bloc_fakestoreapi/domain/entities/users.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../datasources/mock_user_data_source.mocks.dart';

void main() {
  late UserRepositoryImpl userRepositoryImpl;
  late MockUserDataSource mockUserDataSource;

  setUp(() {
    mockUserDataSource = MockUserDataSource();
    userRepositoryImpl = UserRepositoryImpl(mockUserDataSource);
  });

  const tUsername = '123';
  const tPassword = '123';
  const tIdUser = '2';

  final sampleUser = UserModel(
      address: AddressModel(
          geolocation: GeolocationModel(lat: '-37.3159', long: '81.1496'),
          city: 'City A',
          street: 'Street A',
          number: 10,
          zipcode: '12926-3874'),
      id: 2,
      email: 'email@gmail.com',
      username: 'username',
      password: 'password',
      name: NameModel(firstname: 'firstname', lastname: 'lastname'),
      phone: '1828271-11');

  test('user login from user data source', () async {
    when(mockUserDataSource.userLogin(tUsername, tPassword))
        .thenAnswer((_) async => 'token');

    final result = await userRepositoryImpl.login(tUsername, tPassword);

    verify(mockUserDataSource.userLogin(tUsername, tPassword));
    expect(result, isA<Right<Failure, String>>());
  });

  test('user login from user data source is unsuccessful', () async {
    when(mockUserDataSource.userLogin(tUsername, tPassword))
        .thenThrow(ServerException());

    final result = await userRepositoryImpl.login(tUsername, tPassword);

    expect(result, isA<Left<Failure, String>>());
  });

  test('user detail from user data source', () async {
    when(mockUserDataSource.userDetail(tIdUser)).thenAnswer(
      (realInvocation) async => sampleUser,
    );

    final result = await userRepositoryImpl.userDetail(tIdUser);
    verify(mockUserDataSource.userDetail(tIdUser));
    expect(result, isA<Right<Failure, UserEntity>>());
  });

  test('user detail from user data source is unsuccessful', () async {
    when(mockUserDataSource.userDetail(tIdUser)).thenThrow(ServerException());

    final result = await userRepositoryImpl.userDetail(tIdUser);

    expect(result, isA<Left<Failure, UserEntity>>());
  });
}
