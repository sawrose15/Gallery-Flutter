import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/app/bloc/app_bloc.dart';
import 'package:photo_gallery/app/routes/routes.dart';
import 'package:photo_gallery/home/home.dart';
import 'package:photo_gallery/login/login.dart';
import 'package:photo_gallery/photos_overview/bloc/photo_overview_bloc.dart';
import 'package:photo_gallery/signup/sign_up.dart';
import 'package:photo_gallery/theme.dart';

import '../../di/di.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<AppBloc>()),
        BlocProvider(create: (_) => getIt<LoginCubit>()),
        BlocProvider(create: (_) => getIt<SignUpCubit>()),
        BlocProvider(create: (_) => getIt<HomeCubit>()),
        BlocProvider(create: (_) => getIt<PhotoOverviewBloc>()),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: FlowBuilder<AppStatus>(
        state: context.select((AppBloc bloc) => bloc.state.status),
        onGeneratePages: onGenerateAppViewPages,
      ),
    );
  }
}
