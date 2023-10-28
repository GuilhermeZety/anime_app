import 'package:anime_app/app/core/common/errors/failures.dart';
import 'package:anime_app/app/core/common/services/treater/treater_service.dart';
import 'package:anime_app/app/core/shared/manga/data/datasources/datasource/manga_datasource.dart';
import 'package:anime_app/app/core/shared/manga/data/models/chapter_release_model.dart';
import 'package:anime_app/app/core/shared/manga/data/models/chapter_slime_model.dart';
import 'package:anime_app/app/core/shared/manga/data/models/manga_slime_model.dart';
import 'package:anime_app/app/core/shared/manga/domain/repositories/manga_repository.dart';
import 'package:dartz/dartz.dart';

class MangaRepositoryImpl extends MangaRepository {
  final MangaDatasource datasource;

  MangaRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, List<MangaSlimeModel>>> search(String value) {
    return TreaterService()<List<MangaSlimeModel>>(
      () async {
        return await datasource.search(value);
      },
      errorIdentification: 'Erro ao buscar o manga',
    );
  }

  @override
  Future<Either<Failure, ChapterSlimeModel>> getChapters(String bookName, int idSerie) {
    return TreaterService()<ChapterSlimeModel>(
      () async {
        return await datasource.getChapters(bookName, idSerie);
      },
      errorIdentification: 'Erro ao buscar capitulos',
    );
  }

  @override
  Future<Either<Failure, List<String>>> getImages(int mangaId, String cap) {
    return TreaterService()<List<String>>(
      () async {
        return await datasource.getImages(mangaId, cap);
      },
      errorIdentification: 'Erro ao buscar imagens do capitulo',
    );
  }

  @override
  Future<Either<Failure, List<BookInfoModel>>> getReleasesMangas(int page) {
    return TreaterService()<List<BookInfoModel>>(
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
