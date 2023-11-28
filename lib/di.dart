import 'package:flutter_bloc_fakestoreapi/data/datasources/user_data_source.dart';
import 'package:flutter_bloc_fakestoreapi/data/datasources/user_data_source_impl.dart';
import 'package:flutter_bloc_fakestoreapi/data/repositories/user_repository_impl.dart';
import 'package:flutter_bloc_fakestoreapi/domain/repositories/user_repository.dart';
import 'package:flutter_bloc_fakestoreapi/domain/usecases/get_user_detail.dart';
import 'package:flutter_bloc_fakestoreapi/domain/usecases/user_login.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/bloc/user_detail/user_detail_bloc.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/bloc/user_login/user_login_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final getIt = GetIt.instance;
void init() {
  getIt.registerLazySingleton(() => http.Client());

  getIt
      .registerLazySingleton<UserDataSource>(() => UserDataSourceImpl(getIt()));

  getIt
      .registerLazySingleton<UserRepository>(() => UserRepositoryImpl(getIt()));

  getIt.registerLazySingleton(() => UserLogin(getIt()));
  getIt.registerLazySingleton(() => UserDetail(getIt()));

  getIt.registerFactory(() => UserLoginBloc(userLogin: getIt()));
  getIt.registerFactory(() => UserDetailBloc(userDetail: getIt()));
}
