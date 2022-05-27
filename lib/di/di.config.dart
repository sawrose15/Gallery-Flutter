// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:cloud_firestore/cloud_firestore.dart' as _i5;
import 'package:firebase_auth/firebase_auth.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i6;

import '../features/authentication/data/datasources/remote_data_source.dart'
    as _i8;
import '../features/authentication/data/repositories/auth_repository.dart'
    as _i10;
import '../features/authentication/data/repositories/network_info.dart' as _i7;
import '../features/authentication/domain/repositories/auth_repository_interface.dart'
    as _i9;
import '../features/authentication/domain/usecases/login_usecase.dart' as _i12;
import '../features/authentication/domain/usecases/logout_usecase.dart' as _i13;
import '../features/authentication/domain/usecases/register_usecase.dart'
    as _i14;
import '../features/authentication/presentation/bloc/authentication_bloc.dart'
    as _i11;
import '../features/authentication/presentation/pages/login/cubit/login_cubit.dart'
    as _i15;
import '../features/core/data/datasources/cache.dart' as _i3;
import 'modules/firebase_module.dart' as _i17;
import 'modules/network_module.dart' as _i16;

const String _prod = 'prod';
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final networkInfo = _$NetworkInfo();
  final firebaseModule = _$FirebaseModule();
  gh.lazySingleton<_i3.Cache>(() => networkInfo.cache);
  gh.lazySingleton<_i4.FirebaseAuth>(() => firebaseModule.firebaseAuth);
  gh.lazySingleton<_i5.FirebaseFirestore>(() => firebaseModule.firestore);
  gh.lazySingleton<_i6.InternetConnectionChecker>(
      () => networkInfo.connectionChecker);
  gh.lazySingleton<_i7.NetworkInfo>(
      () => _i7.NetworkInfoImpl(get<_i6.InternetConnectionChecker>()));
  gh.lazySingleton<_i8.RemoteDataSource>(() => _i8.RemoteDataSourceImpl());
  gh.lazySingleton<_i9.AuthRepositoryInterface>(
      () => _i10.AuthRepository(get<_i8.RemoteDataSource>()),
      registerFor: {_prod});
  gh.factory<_i11.AuthenticationBloc>(() =>
      _i11.AuthenticationBloc(repository: get<_i9.AuthRepositoryInterface>()));
  gh.lazySingleton<_i12.LoginUsecase>(
      () => _i12.LoginUsecase(get<_i9.AuthRepositoryInterface>()));
  gh.lazySingleton<_i13.LogoutUsecase>(
      () => _i13.LogoutUsecase(get<_i9.AuthRepositoryInterface>()));
  gh.lazySingleton<_i14.RegisterUsecase>(
      () => _i14.RegisterUsecase(get<_i9.AuthRepositoryInterface>()));
  gh.factory<_i15.LoginCubit>(() => _i15.LoginCubit(get<_i12.LoginUsecase>()));
  return get;
}

class _$NetworkInfo extends _i16.NetworkInfo {}

class _$FirebaseModule extends _i17.FirebaseModule {}
