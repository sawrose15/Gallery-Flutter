// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:authentication_repository/authentication_repository.dart'
    as _i3;
import 'package:cloud_firestore/cloud_firestore.dart' as _i5;
import 'package:firebase_auth/firebase_auth.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:photo_api/photo_api.dart' as _i8;

import '../app/bloc/app_bloc.dart' as _i13;
import '../home/cubit/home_cubit.dart' as _i6;
import '../login/cubit/login_cubit.dart' as _i7;
import '../photo_detail/bloc/photo_detail_bloc.dart' as _i9;
import '../photos_overview/bloc/photo_overview_bloc.dart' as _i10;
import '../shared/bloc/shared_bloc.dart' as _i11;
import '../signup/cubit/sign_up_cubit.dart' as _i12;
import 'modules/authentication_module.dart' as _i14;
import 'modules/firebase_module.dart'
    as _i15; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final authenticationModule = _$AuthenticationModule();
  final firebaseModule = _$FirebaseModule();
  gh.lazySingleton<_i3.AuthenticationRepository>(
      () => authenticationModule.authenticationRepository);
  gh.lazySingleton<_i4.FirebaseAuth>(() => firebaseModule.firebaseAuth);
  gh.lazySingleton<_i5.FirebaseFirestore>(() => firebaseModule.firestore);
  gh.factory<_i6.HomeCubit>(() => _i6.HomeCubit());
  gh.factory<_i7.LoginCubit>(
      () => _i7.LoginCubit(get<_i3.AuthenticationRepository>()));
  gh.lazySingleton<_i8.PhotoApi>(() => firebaseModule.firebasePhotoApi);
  gh.factory<_i9.PhotoDetailBloc>(() => _i9.PhotoDetailBloc());
  gh.factory<_i10.PhotoOverviewBloc>(() => _i10.PhotoOverviewBloc(
      authenticationRepository: get<_i3.AuthenticationRepository>(),
      photoApi: get<_i8.PhotoApi>()));
  gh.factory<_i11.SharedBloc>(() => _i11.SharedBloc());
  gh.factory<_i12.SignUpCubit>(
      () => _i12.SignUpCubit(get<_i3.AuthenticationRepository>()));
  gh.factory<_i13.AppBloc>(() => _i13.AppBloc(
      authenticationRepository: get<_i3.AuthenticationRepository>()));
  return get;
}

class _$AuthenticationModule extends _i14.AuthenticationModule {}

class _$FirebaseModule extends _i15.FirebaseModule {}
