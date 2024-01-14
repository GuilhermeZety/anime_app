import 'package:anime_app/app/core/common/errors/failures.dart';
import 'package:anime_app/app/core/common/services/treater/treater_service.dart';
import 'package:anime_app/app/core/shared/animes/data/datasources/datasource/anime_datasource.dart';
import 'package:anime_app/app/core/shared/animes/data/models/anime_model.dart';
import 'package:anime_app/app/core/shared/animes/domain/repositories/anime_repository.dart';
import 'package:dartz/dartz.dart';

class AnimeRepositoryImpl extends AnimeRepository {
  final AnimeDatasource datasource;

  AnimeRepositoryImpl({
    required this.datasource,
  });

  @override
  Future<Either<Failure, List<AnimeModel>>> getAnimes(String? value, int page) {
    return TreaterService()<List<AnimeModel>>(
      () async {
        return await datasource.getAnimes(value, page);
      },
      errorIdentification: 'Erro ao buscar os animes',
    );
  }
}
