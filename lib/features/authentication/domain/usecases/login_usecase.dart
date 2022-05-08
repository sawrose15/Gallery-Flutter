import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:photo_gallery/features/authentication/domain/repositories/auth_repository.dart';
import 'package:photo_gallery/features/core/data/models/failure.dart';
import 'package:photo_gallery/features/core/domain/entities/models.dart';
import 'package:photo_gallery/features/core/domain/usecases/usecase.dart';

@lazySingleton
class LoginUsecase extends Usecase<User, UserParams> {
  final AuthRepository _repository;

  LoginUsecase(this._repository);

  @override
  Future<Either<Failure, User>> execute(UserParams params) async {
    try {
      return _repository.loginWithEmailAndPassword(params);
    } catch (e) {
      return Left(ServerFailure.unknown());
    }
  }
}
