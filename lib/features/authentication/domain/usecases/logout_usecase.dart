import 'package:injectable/injectable.dart';
import 'package:photo_gallery/features/authentication/domain/repositories/auth_repository_interface.dart';
import 'package:photo_gallery/features/core/data/models/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:photo_gallery/features/core/domain/usecases/usecase.dart';

@lazySingleton
class LogoutUsecase extends UseCase<bool, NoParams> {
  final AuthRepositoryInterface _repository;

  LogoutUsecase(this._repository);

  @override
  Future<Either<Failure, bool>> execute(NoParams params) async {
    return await _repository.logout();
  }
}
