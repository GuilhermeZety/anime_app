import 'package:anime_app/app/core/common/errors/failures.dart';
import 'package:anime_app/app/core/shared/manga/data/models/chapter_slime_model.dart';
import 'package:anime_app/app/core/shared/manga/domain/entities/chapter_release_entity.dart';
import 'package:anime_app/app/core/shared/manga/domain/entities/manga_slime_entity.dart';
import 'package:dartz/dartz.dart';

abstract class MangaRepository {
  Future<Either<Failure, List<MangaSlimeEntity>>> search(String value);
  Future<Either<Failure, ChapterSlimeModel>> getChapters(String bookName, int idSerie);
  Future<Either<Failure, List<String>>> getImages(int mangaId, String cap);
  Future<Either<Failure, List<BookInfoModel>>> getReleasesMangas(int page);
  Future<Either<Failure, String>> getDescription(String url);
}
