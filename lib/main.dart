import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_fakestoreapi/di.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/bloc/user_detail/user_detail_bloc.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/bloc/user_login/user_login_bloc.dart';
import 'package:flutter_bloc_fakestoreapi/presentation/pages/login_page/login_page.dart';

void main() {
  init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => getIt<UserLoginBloc>()
              ..add(FetchUserLogin('mor_2314', '83r5^_')),
          ),
          BlocProvider(
            create: (context) => getIt<UserDetailBloc>(),
          ),
        ],
        child: const LoginPage(),
      ),
    );
  }
}
