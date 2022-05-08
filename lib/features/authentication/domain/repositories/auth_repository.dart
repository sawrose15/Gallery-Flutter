import 'package:dartz/dartz.dart';
import 'package:photo_gallery/features/core/data/models/failure.dart';
import 'package:photo_gallery/features/core/domain/entities/models.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> loginWithEmailAndPassword(
    UserParams params,
  );

  Future<Either<Failure, User>> registerWithEmailAndPassword(
    UserParams params,
  );

  Future<Either<Failure, bool>> logout();
}

class UserParams {
  final String Email;
  final String Password;

  UserParams(this.Email, this.Password);
}
