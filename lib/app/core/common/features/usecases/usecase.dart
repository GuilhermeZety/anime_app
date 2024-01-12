import 'package:anime_app/app/core/common/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class Usecase<ReturnType, Params> {
  Future<Either<Failure, ReturnType>> call(Params params);
}

abstract class StreamUsecase<ReturnType, Params> {
  Future<Either<Failure, Stream<ReturnType>>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
