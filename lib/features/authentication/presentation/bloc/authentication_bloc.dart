import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:photo_gallery/features/authentication/domain/entities/user.dart';
import 'package:photo_gallery/features/authentication/domain/repositories/auth_repository_interface.dart';
import 'package:photo_gallery/features/authentication/domain/usecases/login_usecase.dart';
import 'package:photo_gallery/features/authentication/domain/usecases/logout_usecase.dart';
import 'package:photo_gallery/features/authentication/domain/usecases/check_authentication_status_usecase.dart';
import 'package:photo_gallery/features/authentication/domain/usecases/register_usecase.dart';
import 'package:photo_gallery/features/core/domain/usecases/usecase.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';
part 'authentication_bloc.freezed.dart';

@injectable
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required LoginUsecase loginUsecase,
    required RegisterUsecase registerUsecase,
    required LogoutUsecase logoutUsecase,
    required CheckAuthenticationStatusUsecase checkAuthenticationStatusUsecase,
  })  : _loginUsecase = loginUsecase,
        _registerUsecase = registerUsecase,
        _logoutUsecase = logoutUsecase,
        _checkAuthenticationStatusUsecase = checkAuthenticationStatusUsecase,
        super(
          const AuthenticationState.initial(),
        ) {
    on<_CheckAuthentication>(_checkAuthentication);
    on<_LoginWithEmailAndPassword>(_loginWithEmailAndPassword);
    on<_RegisterWithEmailAndPassword>(_registerWithEmailAndPassword);
    on<_LoggedOut>(_loggedOut);
  }
  final LoginUsecase _loginUsecase;
  final RegisterUsecase _registerUsecase;
  final LogoutUsecase _logoutUsecase;
  final CheckAuthenticationStatusUsecase _checkAuthenticationStatusUsecase;

  //User
  User _user = User.empty;
  User get user => _user;

  FutureOr<void> _checkAuthentication(
    _CheckAuthentication event,
    Emitter<AuthenticationState> emitter,
  ) async {
    final result =
        await _checkAuthenticationStatusUsecase.execute(const NoParams());
    result.fold(
        (failure) => {
              debugPrint('AuthenticationState: Unauthenticated'),
              emitter(const AuthenticationState.unauthenticated())
            },
        (user) => {
              debugPrint('AuthenticationState: Authenticated'),
              _user = user,
              emitter(AuthenticationState.authenticated(user)),
            });
  }

  FutureOr<void> _loginWithEmailAndPassword(
    _LoginWithEmailAndPassword event,
    Emitter<AuthenticationState> emitter,
  ) async {
    final result =
        await _loginUsecase.execute(UserParams(event.email, event.password));
    result.fold(
      (failure) => emitter(const AuthenticationState.unauthenticated()),
      (user) => {
        _user = user,
        emitter(AuthenticationState.authenticated(user)),
      },
    );
  }

  FutureOr<void> _registerWithEmailAndPassword(
    _RegisterWithEmailAndPassword event,
    Emitter<AuthenticationState> emitter,
  ) async {
    final result = await _registerUsecase.execute(
      UserParams(event.email, event.password),
    );
    result.fold(
      (failure) => emitter(const AuthenticationState.unauthenticated()),
      (user) => {
        _user = user,
        emitter(AuthenticationState.authenticated(user)),
      },
    );
  }

  FutureOr<void> _loggedOut(
    _LoggedOut event,
    Emitter<AuthenticationState> emitter,
  ) async {
    await _logoutUsecase.execute(const NoParams());
    emitter(const AuthenticationState.unauthenticated());
  }
}
