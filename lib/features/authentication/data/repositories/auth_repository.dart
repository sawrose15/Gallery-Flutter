import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:photo_gallery/features/authentication/data/datasources/remote_data_source.dart';
import 'package:photo_gallery/features/authentication/domain/entities/user.dart';
import 'package:photo_gallery/features/authentication/domain/repositories/auth_repository_interface.dart';
import 'package:photo_gallery/features/core/data/datasources/cache.dart';
import 'package:photo_gallery/features/core/data/models/exceptions.dart';
import 'package:photo_gallery/features/core/data/models/failure.dart';

@prod
@LazySingleton(as: AuthRepositoryInterface)
class AuthRepository implements AuthRepositoryInterface {
  final Cache cache = Cache.init();
  final RemoteDataSource remote;

  @visibleForTesting
  static const userCacheKey = '__user_cache_key__';

  AuthRepository(
    this.remote,
  );

  @override
  Future<Either<Failure, User>> loginWithEmailAndPassword(
    UserParams params,
  ) async {
    try {
      final result = await remote.loginWithEmailAndPassword(params);
      Cache.saveData(key: userCacheKey, value: result);
      return Right(result);
    } on ServerException catch (ex) {
      return Left(ServerFailure(ex.message));
    } on RegisterException {
      return Left(RegisterFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      final result = await remote.logout();
      Cache.removeData(userCacheKey);
      return Right(result);
    } on ServerException catch (ex) {
      return Left(ServerFailure(ex.message));
    } on LogoutException {
      return Left(LogoutFailure());
    }
  }

  @override
  Future<Either<Failure, User>> registerWithEmailAndPassword(
    UserParams params,
  ) async {
    try {
      final result = await remote.registerWithEmailAndPassword(params);
      Cache.saveData(key: userCacheKey, value: result);
      return Right(result);
    } on ServerException catch (ex) {
      return Left(ServerFailure(ex.message));
    } on RegisterException {
      return Left(RegisterFailure());
    }
  }

  @override
  Future<Either<Failure, User>> checkAuthentication() async {
    try {
      final result = await Cache.getData(key: userCacheKey);
      return Right(result);
    } on ServerException catch (ex) {
      return Left(ServerFailure(ex.message));
    } on CheckAuthenticationException {
      return Left(CheckAuthenticationFailure());
    }
  }
}
