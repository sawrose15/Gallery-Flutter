import 'package:injectable/injectable.dart';
import 'package:photo_gallery/features/core/data/datasources/network/auth_service.dart';
import 'package:photo_gallery/features/core/domain/entities/models.dart';
import 'package:photo_gallery/features/core/data/models/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:photo_gallery/features/core/domain/repositories/repositories.dart';

@prod
@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthService _service;

  AuthRepositoryImpl(this._service);
  @override
  Future<Either<Failure, User>> loginWithEmailAndPassword(
      UserParams params) async {
    try {
      final result =
          await _service.loginWithUser(params.Email, params.Password);
      return right(result);
    } on ServerError catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (_) {
      return left(ServerFailure.unknown());
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      final result = await _service.logout();
      return right(result);
    } on ServerError catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (_) {
      return left(ServerFailure.unknown());
    }
  }

  @override
  Future<Either<Failure, User>> registerWithEmailAndPassword(
      UserParams params) async {
    try {
      final result = await _service.signUpUser(params.Email, params.Password);
      return right(result);
    } on ServerError catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (_) {
      return left(ServerFailure.unknown());
    }
  }

  @override
  Future<Option<User>> getSignedInUser() {
    // TODO: implement getSignedInUser
    throw UnimplementedError();
  }
}
