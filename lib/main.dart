import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/app/app.dart';

Future<void> main() {
  return BlocOverrides.runZoned(
      () async {
        WidgetsFlutterBinding.ensureInitialized();
        await Firebase.initializeApp();
        final authenticationRepository = AuthenticationRepository();
        await authenticationRepository.user.first;
        runApp(App(authenticationRepository: authenticationRepository));
      },
    blocObserver: AppBlocObserver(),
  );
}

