import 'package:anime_app/app/core/common/errors/failures.dart';
import 'package:anime_app/app/core/shared/manga/domain/entities/chapter_entity.dart';
import 'package:anime_app/app/core/shared/manga/domain/entities/chapter_release_entity.dart';
import 'package:anime_app/app/core/shared/manga/domain/entities/images_entity.dart';
import 'package:anime_app/app/core/shared/manga/domain/entities/manga_entity.dart';
import 'package:dartz/dartz.dart';

abstract class MangaRepository {
  Future<Either<Failure, List<MangaEntity>>> search(String value);
  Future<Either<Failure, List<ChapterEntity>>> getChapters(int? page, int idSerie);
  Future<Either<Failure, List<ImagesEntity>>> getImages(int idRelease);
  Future<Either<Failure, List<ChapterReleaseEntity>>> getReleasesMangas(int page);
  Future<Either<Failure, String>> getDescription(String url);
}
