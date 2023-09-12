import 'package:anime_app/app/core/common/errors/failures.dart';
import 'package:anime_app/app/core/common/services/treater/treater_service.dart';
import 'package:anime_app/app/core/shared/anime/data/datasources/datasource/anime_datasource.dart';
import 'package:anime_app/app/core/shared/anime/data/models/anime_model.dart';
import 'package:anime_app/app/core/shared/anime/domain/repositories/anime_repository.dart';
import 'package:dartz/dartz.dart';

class AnimeRepositoryImpl extends AnimeRepository {
  final AnimeDatasource datasource;

  AnimeRepositoryImpl({
    required this.datasource,
  });

  @override
  Future<Either<Failure, List<AnimeModel>>> search(String value) {
    return TreaterService()<List<AnimeModel>>(
      () async {
        return await datasource.search(value);
      },
      errorIdentification: 'Erro ao buscar o anime',
    );
  }
}
