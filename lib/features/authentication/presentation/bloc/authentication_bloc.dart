import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:photo_gallery/features/authentication/domain/entities/user.dart';
import 'package:photo_gallery/features/authentication/domain/repositories/auth_repository_interface.dart';
import 'package:photo_gallery/features/authentication/domain/usecases/check_auth_usecase.dart';
import 'package:photo_gallery/features/authentication/domain/usecases/login_usecase.dart';
import 'package:photo_gallery/features/authentication/domain/usecases/logout_usecase.dart';
import 'package:photo_gallery/features/authentication/domain/usecases/register_usecase.dart';
import 'package:photo_gallery/features/core/domain/usecases/usecase.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

@injectable
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required LoginUsecase loginUsecase,
    required RegisterUsecase registerUsecase,
    required LogoutUsecase logoutUsecase,
    required CheckAuthenticationUsecase checkAuthenticationUsecase,
  })  : _loginUsecase = loginUsecase,
        _registerUsecase = registerUsecase,
        _logoutUsecase = logoutUsecase,
        _checkAuthenticationUsecase = checkAuthenticationUsecase,
        super(
          const AuthenticationState.unauthenticated(),
        ) {
    on<AppLogoutRequested>(_onLogoutRequested);
  }
  final LoginUsecase _loginUsecase;
  final LogoutUsecase _logoutUsecase;
  final RegisterUsecase _registerUsecase;
  final CheckAuthenticationUsecase _checkAuthenticationUsecase;

  FutureOr<void> _onLogoutRequested(
    AppLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    final response = await _logoutUsecase.execute(const NoParams());
    response.fold((failure) => null, (r) => null,)
  }
}
