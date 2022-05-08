import 'package:injectable/injectable.dart';
import 'package:photo_gallery/features/authentication/domain/repositories/auth_repository.dart';
import 'package:photo_gallery/features/core/data/models/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:photo_gallery/features/core/domain/usecases/usecase.dart';

@lazySingleton
class LogoutUsecase extends Usecase<bool, NoParams> {
  final AuthRepository _repository;

  LogoutUsecase(this._repository);
  @override
  Future<Either<Failure, bool>> execute(NoParams params) async {
    try {
      return _repository.logout();
    } catch (e) {
      return Left(ServerFailure.unknown());
    }
  }
}
