import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:photo_gallery/features/authentication/domain/entities/user.dart';
import 'package:photo_gallery/features/authentication/domain/repositories/auth_repository_interface.dart';
import 'package:photo_gallery/features/core/data/models/failure.dart';
import 'package:photo_gallery/features/core/domain/usecases/usecase.dart';

@lazySingleton
class LoginUsecase extends UseCase<User, UserParams> {
  final AuthRepositoryInterface _repository;

  LoginUsecase(this._repository);

  @override
  Future<Either<Failure, User>> execute(UserParams params) async {
    return await _repository.loginWithEmailAndPassword(params);
  }
}
