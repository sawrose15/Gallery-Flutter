import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:photo_gallery/features/authentication/data/datasources/remote_data_source.dart';
import 'package:photo_gallery/features/authentication/domain/entities/user.dart';
import 'package:photo_gallery/features/authentication/domain/repositories/auth_repository_interface.dart';
import 'package:photo_gallery/features/core/data/models/exceptions.dart';
import 'package:photo_gallery/features/core/data/models/failure.dart';

@prod
@LazySingleton(as: AuthRepositoryInterface)
class AuthRepository implements AuthRepositoryInterface {
  final RemoteDataSource remote;

  AuthRepository(
    this.remote,
  );

  @override
  Future<Either<Failure, User>> loginWithEmailAndPassword(
    UserParams params,
  ) async {
    try {
      final result = await remote.loginWithEmailAndPassword(params);
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
      final user = await remote.checkAuthentication();
      return Right(user);
    } on ServerException catch (ex) {
      return Left(ServerFailure(ex.message));
    }
  }
}
