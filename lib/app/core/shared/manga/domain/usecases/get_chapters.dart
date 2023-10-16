import 'package:anime_app/app/core/common/errors/failures.dart';
import 'package:anime_app/app/core/common/features/usecases/usecase.dart';
import 'package:anime_app/app/core/shared/manga/domain/entities/chapter_entity.dart';
import 'package:anime_app/app/core/shared/manga/domain/repositories/manga_repository.dart';
import 'package:dartz/dartz.dart';

class GetChapters extends Usecase<List<ChapterEntity>, GetChaptersParams> {
  final MangaRepository repository;

  GetChapters({required this.repository});

  @override
  Future<Either<Failure, List<ChapterEntity>>> call(
    GetChaptersParams params,
  ) async {
    return await repository.getChapters(params.page, params.idSerie);
  }
}

class GetChaptersParams {
  final int? page;
  final int idSerie;

  GetChaptersParams({
    required this.page,
    required this.idSerie,
  });
}
