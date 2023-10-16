import 'package:anime_app/app/core/common/errors/failures.dart';
import 'package:anime_app/app/core/common/services/treater/treater_service.dart';
import 'package:anime_app/app/core/shared/manga/data/datasources/datasource/manga_datasource.dart';
import 'package:anime_app/app/core/shared/manga/data/models/chapter_model.dart';
import 'package:anime_app/app/core/shared/manga/data/models/chapter_release_model.dart';
import 'package:anime_app/app/core/shared/manga/data/models/images_model.dart';
import 'package:anime_app/app/core/shared/manga/data/models/manga_model.dart';
import 'package:anime_app/app/core/shared/manga/domain/repositories/manga_repository.dart';
import 'package:dartz/dartz.dart';

class MangaRepositoryImpl extends MangaRepository {
  final MangaDatasource datasource;

  MangaRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, List<MangaModel>>> search(String value) {
    return TreaterService()<List<MangaModel>>(
      () async {
        return await datasource.search(value);
      },
      errorIdentification: 'Erro ao buscar o manga',
    );
  }

  @override
  Future<Either<Failure, List<ChapterModel>>> getChapters(int? page, int idSerie) {
    return TreaterService()<List<ChapterModel>>(
      () async {
        return await datasource.getChapters(page, idSerie);
      },
      errorIdentification: 'Erro ao buscar capitulos',
    );
  }

  @override
  Future<Either<Failure, List<ImagesModel>>> getImages(int idRelease) {
    return TreaterService()<List<ImagesModel>>(
      () async {
        return await datasource.getImages(idRelease);
      },
      errorIdentification: 'Erro ao buscar imagens do capitulo',
    );
  }

  @override
  Future<Either<Failure, List<ChapterReleaseModel>>> getReleasesMangas(int page) {
    return TreaterService()<List<ChapterReleaseModel>>(
      () async {
        return await datasource.getReleasesMangas(page);
      },
      errorIdentification: 'Erro ao buscar lançamentos',
    );
  }

  @override
  Future<Either<Failure, String>> getDescription(String url) {
    return TreaterService()<String>(
      () async {
        return await datasource.getDescription(url);
      },
      errorIdentification: 'Erro ao buscar lançamentos',
    );
  }
}
