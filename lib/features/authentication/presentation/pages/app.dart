import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:photo_gallery/di/di.dart';
import 'package:photo_gallery/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:photo_gallery/features/authentication/presentation/pages/login/cubit/login_cubit.dart';
import 'package:photo_gallery/features/authentication/presentation/pages/login/views/login_page.dart';
import 'package:photo_gallery/features/home/presentation/pages/home_page.dart';
import 'package:photo_gallery/theme.dart';
import 'package:photo_gallery/utils/app_route.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<AuthenticationBloc>(),
        ),
        BlocProvider(create: (_) => getIt<LoginCubit>()),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();
    return Observer(
      builder: (_) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        initialRoute: '/',
        onGenerateRoute: appRouter.onGenerateRoute,
        routes: {
          "/": (context) {
            return BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
              switch (state.status) {
                case AuthenticationStatus.authenticated:
                  return const HomePage();
                case AuthenticationStatus.unauthenticated:
                  return const LoginPage();
              }
            });
          }
        },
      ),
    );
  }
}
