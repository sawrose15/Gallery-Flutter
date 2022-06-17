import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:photo_gallery/features/authentication/domain/entities/user.dart';
import 'package:photo_gallery/features/authentication/domain/repositories/auth_repository_interface.dart';
import 'package:photo_gallery/features/core/data/models/failure.dart';
import 'package:photo_gallery/features/core/domain/usecases/usecase.dart';

@lazySingleton
class CheckAuthenticationStatusUsecase implements UseCase<User, NoParams> {
  CheckAuthenticationStatusUsecase(this.repository);

  final AuthRepositoryInterface repository;

  @override
  Future<Either<Failure, User>> execute(NoParams params) async {
    return await repository.checkAuthentication();
  }
}
