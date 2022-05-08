// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:authentication_repository/authentication_repository.dart'
    as _i4;
import 'package:cloud_firestore/cloud_firestore.dart' as _i6;
import 'package:firebase_auth/firebase_auth.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:photo_api/photo_api.dart' as _i12;

import '../app/bloc/app_bloc.dart' as _i17;
import '../features/authentication/data/repositories/auth_repository.dart'
    as _i19;
import '../features/authentication/domain/repositories/auth_repository.dart'
    as _i10;
import '../features/authentication/domain/usecases/login_usecase.dart' as _i9;
import '../features/authentication/domain/usecases/logout_usecase.dart' as _i11;
import '../features/authentication/domain/usecases/register_usecase.dart'
    as _i20;
import '../features/core/data/datasources/network/auth_service.dart' as _i3;
import '../features/core/domain/repositories/repositories.dart' as _i18;
import '../home/cubit/home_cubit.dart' as _i7;
import '../login/cubit/login_cubit.dart' as _i8;
import '../photo_detail/bloc/photo_detail_bloc.dart' as _i13;
import '../photos_overview/bloc/photo_overview_bloc.dart' as _i14;
import '../shared/bloc/shared_bloc.dart' as _i15;
import '../signup/cubit/sign_up_cubit.dart' as _i16;
import 'modules/authentication_module.dart' as _i21;
import 'modules/firebase_module.dart' as _i22;

const String _prod = 'prod';
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final authenticationModule = _$AuthenticationModule();
  final firebaseModule = _$FirebaseModule();
  gh.lazySingleton<_i3.AuthService>(() => _i3.AuthServiceImpl());
  gh.lazySingleton<_i4.AuthenticationRepository>(
      () => authenticationModule.authenticationRepository);
  gh.lazySingleton<_i5.FirebaseAuth>(() => firebaseModule.firebaseAuth);
  gh.lazySingleton<_i6.FirebaseFirestore>(() => firebaseModule.firestore);
  gh.factory<_i7.HomeCubit>(() => _i7.HomeCubit());
  gh.factory<_i8.LoginCubit>(
      () => _i8.LoginCubit(get<_i4.AuthenticationRepository>()));
  gh.lazySingleton<_i9.LoginUsecase>(
      () => _i9.LoginUsecase(get<_i10.AuthRepository>()));
  gh.lazySingleton<_i11.LogoutUsecase>(
      () => _i11.LogoutUsecase(get<_i10.AuthRepository>()));
  gh.lazySingleton<_i12.PhotoApi>(() => firebaseModule.firebasePhotoApi);
  gh.factory<_i13.PhotoDetailBloc>(() => _i13.PhotoDetailBloc());
  gh.factory<_i14.PhotoOverviewBloc>(
      () => _i14.PhotoOverviewBloc(photoApi: get<_i12.PhotoApi>()));
  gh.factory<_i15.SharedBloc>(() => _i15.SharedBloc());
  gh.factory<_i16.SignUpCubit>(
      () => _i16.SignUpCubit(get<_i4.AuthenticationRepository>()));
  gh.factory<_i17.AppBloc>(() => _i17.AppBloc(
      authenticationRepository: get<_i4.AuthenticationRepository>()));
  gh.lazySingleton<_i18.AuthRepository>(
      () => _i19.AuthRepositoryImpl(get<_i3.AuthService>()),
      registerFor: {_prod});
  gh.lazySingleton<_i20.RegisterUsecase>(
      () => _i20.RegisterUsecase(get<_i18.AuthRepository>()));
  return get;
}

class _$AuthenticationModule extends _i21.AuthenticationModule {}

class _$FirebaseModule extends _i22.FirebaseModule {}
