// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:cloud_firestore/cloud_firestore.dart' as _i6;
import 'package:firebase_auth/firebase_auth.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i7;
import 'package:photo_gallery/di/modules/firebase_module.dart' as _i19;
import 'package:photo_gallery/di/modules/network_module.dart' as _i18;
import 'package:photo_gallery/features/authentication/data/datasources/remote_data_source.dart'
    as _i9;
import 'package:photo_gallery/features/authentication/data/repositories/auth_repository.dart'
    as _i11;
import 'package:photo_gallery/features/authentication/data/repositories/network_info.dart'
    as _i8;
import 'package:photo_gallery/features/authentication/domain/repositories/auth_repository_interface.dart'
    as _i10;
import 'package:photo_gallery/features/authentication/domain/usecases/check_authentication_status_usecase.dart'
    as _i12;
import 'package:photo_gallery/features/authentication/domain/usecases/login_usecase.dart'
    as _i13;
import 'package:photo_gallery/features/authentication/domain/usecases/logout_usecase.dart'
    as _i14;
import 'package:photo_gallery/features/authentication/domain/usecases/register_usecase.dart'
    as _i15;
import 'package:photo_gallery/features/authentication/presentation/bloc/authentication_bloc.dart'
    as _i16;
import 'package:photo_gallery/features/authentication/presentation/pages/login/cubit/login_cubit.dart'
    as _i17;
import 'package:photo_gallery/utils/app_route.gr.dart' as _i3;
import 'package:photo_gallery/utils/AuthGuard.dart' as _i4;

const String _prod = 'prod';
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final networkInfo = _$NetworkInfo();
  final firebaseModule = _$FirebaseModule();
  gh.lazySingleton<_i3.AppRoute>(() => networkInfo.router);
  gh.factory<_i4.AuthGuard>(() => _i4.AuthGuard());
  gh.lazySingleton<_i5.FirebaseAuth>(() => firebaseModule.firebaseAuth);
  gh.lazySingleton<_i6.FirebaseFirestore>(() => firebaseModule.firestore);
  gh.lazySingleton<_i7.InternetConnectionChecker>(
      () => networkInfo.connectionChecker);
  gh.lazySingleton<_i8.NetworkInfo>(
      () => _i8.NetworkInfoImpl(get<_i7.InternetConnectionChecker>()));
  gh.lazySingleton<_i9.RemoteDataSource>(() => _i9.RemoteDataSourceImpl());
  gh.lazySingleton<_i10.AuthRepositoryInterface>(
      () => _i11.AuthRepository(get<_i9.RemoteDataSource>()),
      registerFor: {_prod});
  gh.lazySingleton<_i12.CheckAuthenticationStatusUsecase>(() =>
      _i12.CheckAuthenticationStatusUsecase(
          get<_i10.AuthRepositoryInterface>()));
  gh.lazySingleton<_i13.LoginUsecase>(
      () => _i13.LoginUsecase(get<_i10.AuthRepositoryInterface>()));
  gh.lazySingleton<_i14.LogoutUsecase>(
      () => _i14.LogoutUsecase(get<_i10.AuthRepositoryInterface>()));
  gh.lazySingleton<_i15.RegisterUsecase>(
      () => _i15.RegisterUsecase(get<_i10.AuthRepositoryInterface>()));
  gh.factory<_i16.AuthenticationBloc>(() => _i16.AuthenticationBloc(
      loginUsecase: get<_i13.LoginUsecase>(),
      registerUsecase: get<_i15.RegisterUsecase>(),
      logoutUsecase: get<_i14.LogoutUsecase>(),
      checkAuthenticationStatusUsecase:
          get<_i12.CheckAuthenticationStatusUsecase>()));
  gh.factory<_i17.LoginCubit>(() => _i17.LoginCubit(get<_i13.LoginUsecase>()));
  return get;
}

class _$NetworkInfo extends _i18.NetworkInfo {}

class _$FirebaseModule extends _i19.FirebaseModule {}
