import 'package:anime_app/app/core/common/errors/failures.dart';
import 'package:anime_app/app/core/shared/animes/domain/entities/anime_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AnimeRepository {
  Future<Either<Failure, List<AnimeEntity>>> getAnimes(String? value, int page);
}
