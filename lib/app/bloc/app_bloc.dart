import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({ required AuthenticationRepository authenticationRepository})
      : super(authenticationRepository.currentUser.isNotEmpty ?
      AppState.authenticated(authenticationRepository.currentUser)
      :const AppState.unauthenticated()
  ) {
    on<AppEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
