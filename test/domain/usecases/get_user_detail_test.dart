import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_fakestoreapi/domain/entities/users.dart';
import 'package:flutter_bloc_fakestoreapi/domain/usecases/get_user_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'mock_user_repository.mocks.dart';

void main() {
  late UserDetail usecase;
  late MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
    usecase = UserDetail(mockUserRepository);
  });

  const tIdUser = '2';

  final sampleUser = UserEntity(
      address: AddressEntity(
          geolocation: GeolocationEntity(lat: '-37.3159', long: '81.1496'),
          city: 'City A',
          street: 'Street A',
          number: 10,
          zipcode: '12926-3874'),
      id: 2,
      email: 'email@gmail.com',
      username: 'userA',
      password: 'passA',
      name: NameEntity(firstname: 'A', lastname: 'A'),
      phone: '1-570-236-7033');

  test('user detail from repository', () async {
    when(mockUserRepository.userDetail(tIdUser))
        .thenAnswer((_) async => Right(sampleUser));

    final result = await usecase(tIdUser);

    expect(result, equals(Right(sampleUser)));
    verify(mockUserRepository.userDetail(tIdUser));
    verifyNoMoreInteractions(mockUserRepository);
  });
}
