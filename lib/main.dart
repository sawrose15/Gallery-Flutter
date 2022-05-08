import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:photo_gallery/app/app.dart';
import 'package:photo_gallery/di/di.dart';
import 'package:photo_gallery/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _setupLogging();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  configureInjection(Environment.prod);
  return BlocOverrides.runZoned(
      () =>
          // final authenticationRepository = getIt<AuthenticationRepository>();
          // await authenticationRepository.user.first;
          runApp(const App()),
      blocObserver: AppBlocObserver());
}

_setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    debugPrint('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}
