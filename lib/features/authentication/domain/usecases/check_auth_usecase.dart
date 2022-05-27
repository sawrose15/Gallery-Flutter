import 'package:dartz/dartz.dart';
import 'package:photo_gallery/features/authentication/domain/entities/user.dart';
import 'package:photo_gallery/features/authentication/domain/repositories/auth_repository_interface.dart';
import 'package:photo_gallery/features/core/data/models/failure.dart';
import 'package:photo_gallery/features/core/domain/usecases/usecase.dart';

class CheckAuthenticationUsecase extends UseCase<User, NoParams> {
  final AuthRepositoryInterface _repositoryInterface;

  CheckAuthenticationUsecase(this._repositoryInterface);

  @override
  Future<Either<Failure, User>> execute(NoParams params) async {
    return await _repositoryInterface.checkAuthentication();
  }
}
