import 'package:anime_app/app/core/common/errors/failures.dart';
import 'package:anime_app/app/core/common/features/usecases/usecase.dart';
import 'package:anime_app/app/core/shared/manga/data/models/chapter_slime_model.dart';
import 'package:anime_app/app/core/shared/manga/domain/repositories/manga_repository.dart';
import 'package:dartz/dartz.dart';

class GetChapters extends Usecase<ChapterSlimeModel, GetChaptersParams> {
  final MangaRepository repository;

  GetChapters({required this.repository});

  @override
  Future<Either<Failure, ChapterSlimeModel>> call(
    GetChaptersParams params,
  ) async {
    return await repository.getChapters(params.bookName, params.idSerie);
  }
}

class GetChaptersParams {
  final String bookName;
  final int idSerie;

  GetChaptersParams({
    required this.bookName,
    required this.idSerie,
  });
}
