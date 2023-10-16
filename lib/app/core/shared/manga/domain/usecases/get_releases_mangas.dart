import 'package:anime_app/app/core/common/errors/failures.dart';
import 'package:anime_app/app/core/common/features/usecases/usecase.dart';
import 'package:anime_app/app/core/shared/manga/domain/entities/chapter_release_entity.dart';
import 'package:anime_app/app/core/shared/manga/domain/repositories/manga_repository.dart';
import 'package:dartz/dartz.dart';

class GetReleasesMangas extends Usecase<List<ChapterReleaseEntity>, GetReleasesMangasParams> {
  final MangaRepository repository;

  GetReleasesMangas({required this.repository});

  @override
  Future<Either<Failure, List<ChapterReleaseEntity>>> call(
    GetReleasesMangasParams params,
  ) async {
    return await repository.getReleasesMangas(params.page);
  }
}

class GetReleasesMangasParams {
  final int page;

  GetReleasesMangasParams({
    required this.page,
  });
}
