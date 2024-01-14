import 'package:anime_app/app/core/common/errors/failures.dart';
import 'package:anime_app/app/core/common/features/usecases/usecase.dart';
import 'package:anime_app/app/core/shared/animes/domain/entities/anime_entity.dart';
import 'package:anime_app/app/core/shared/animes/domain/repositories/anime_repository.dart';
import 'package:dartz/dartz.dart';

class GetAnimes extends Usecase<List<AnimeEntity>, GetAnimesParams> {
  final AnimeRepository repository;

  GetAnimes({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<AnimeEntity>>> call(
    GetAnimesParams params,
  ) async {
    return await repository.getAnimes(params.value, params.page ?? 1);
  }
}

class GetAnimesParams {
  final String? value;
  final int? page;

  GetAnimesParams({
    this.value,
    this.page,
  });
}
