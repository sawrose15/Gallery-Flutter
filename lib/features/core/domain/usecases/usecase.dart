import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:photo_gallery/features/core/data/models/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> execute(Params params);
}

class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object> get props => [];
}
