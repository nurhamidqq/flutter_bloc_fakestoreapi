import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_fakestoreapi/domain/usecases/user_login.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'mock_user_repository.mocks.dart';

void main() {
  late UserLogin usecase;
  late MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
    usecase = UserLogin(mockUserRepository);
  });

  const String tUsername = "userA";
  const String tPassword = "passA";

  const sampleResponse = '''{
    "token": "sampleToken"}''';

  test('user login from repository', () async {
    when(mockUserRepository.login(tUsername, tPassword))
        .thenAnswer((_) async => const Right(sampleResponse));

    final result = await usecase(tUsername, tPassword);

    expect(result, equals(const Right(sampleResponse)));
    verify(mockUserRepository.login(tUsername, tPassword));
    verifyNoMoreInteractions(mockUserRepository);
  });
}
