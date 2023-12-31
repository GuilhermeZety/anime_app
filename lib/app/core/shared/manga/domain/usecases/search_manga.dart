import 'package:anime_app/app/core/common/errors/failures.dart';
import 'package:anime_app/app/core/common/features/usecases/usecase.dart';
import 'package:anime_app/app/core/shared/manga/domain/entities/manga_slime_entity.dart';
import 'package:anime_app/app/core/shared/manga/domain/repositories/manga_repository.dart';
import 'package:dartz/dartz.dart';

class SearchManga extends Usecase<List<MangaSlimeEntity>, SearchMangaParams> {
  final MangaRepository repository;

  SearchManga({required this.repository});

  @override
  Future<Either<Failure, List<MangaSlimeEntity>>> call(
    SearchMangaParams params,
  ) async {
    return await repository.search(params.value);
  }
}

class SearchMangaParams {
  final String value;

  SearchMangaParams({
    required this.value,
  });
}
