import 'package:authentication_repository/authentication_repository.dart';
import 'package:firestore_photo_api/firebase_photo_api.dart';
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

class App extends StatelessWidget {
  const App({
    Key? key,
    required AuthenticationRepository authenticationRepository,
    required FirebasePhotoApi firebasePhotoApi,
  })  : _authenticationRepository = authenticationRepository,
        _firebasePhotoApi = firebasePhotoApi,
        super(key: key);

  final AuthenticationRepository _authenticationRepository;
  final FirebasePhotoApi _firebasePhotoApi;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(value: _authenticationRepository),
          RepositoryProvider.value(value: _firebasePhotoApi),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (_) => AppBloc(
                    authenticationRepository: _authenticationRepository)),
            BlocProvider(create: (context) => LoginCubit(
                _authenticationRepository)),
            BlocProvider(create: (context) => SignUpCubit(
                _authenticationRepository)),
            BlocProvider(create: (_) => HomeCubit()),
            BlocProvider(
                create: (_) =>
                    PhotoOverviewBloc(firebasePhotoApi: _firebasePhotoApi)),
          ],
          child: const AppView(),
        ));
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
