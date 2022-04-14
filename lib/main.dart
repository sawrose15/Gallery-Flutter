import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firestore_photo_api/firebase_photo_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/app/app.dart';
import 'package:photo_gallery/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final authenticationRepository = AuthenticationRepository();
  runApp(App(authenticationRepository: authenticationRepository,));
  // return BlocOverrides.runZoned(
  //     () async {
  //       WidgetsFlutterBinding.ensureInitialized();
  //       await Firebase.initializeApp();
  //       final authenticationRepository = AuthenticationRepository();
  //       await authenticationRepository.user.first;
  //       runApp(App(authenticationRepository: authenticationRepository));
  //     },
  //   blocObserver: AppBlocObserver(),
  // );
}

