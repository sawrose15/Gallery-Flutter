import 'package:injectable/injectable.dart';
import 'package:photo_gallery/features/core/data/models/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:photo_gallery/features/core/domain/entities/models.dart';
import 'package:photo_gallery/features/core/domain/repositories/repositories.dart';
import 'package:photo_gallery/features/core/domain/usecases/usecase.dart';

@lazySingleton
class RegisterUsecase extends Usecase<User, UserParams> {
  final AuthRepository _repository;

  RegisterUsecase(this._repository);

  @override
  Future<Either<Failure, User>> execute(UserParams params) async {
    try {
      return _repository.registerWithEmailAndPassword(params);
    } catch (e) {
      return Left(ServerFailure.unknown());
    }
  }
}
