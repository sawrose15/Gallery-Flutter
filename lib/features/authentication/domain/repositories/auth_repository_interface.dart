import 'package:dartz/dartz.dart';

import 'package:photo_gallery/features/authentication/domain/entities/user.dart';
import 'package:photo_gallery/features/core/data/models/failure.dart';

abstract class AuthRepositoryInterface {
  Future<Either<Failure, User>> loginWithEmailAndPassword(UserParams params);
  Future<Either<Failure, User>> registerWithEmailAndPassword(
    UserParams params,
  );
  Future<Either<Failure, User>> checkAuthentication();
  Future<Either<Failure, bool>> logout();
}

class UserParams {
  final String email;
  final String password;

  UserParams(this.email, this.password);
}
