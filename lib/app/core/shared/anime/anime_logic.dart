import 'package:anime_app/app/core/shared/anime/data/datasources/datasource/animetube_datasource_impl.dart';
import 'package:anime_app/app/core/shared/anime/data/repositories/anime_repository_impl.dart';
import 'package:anime_app/app/core/shared/anime/domain/repositories/anime_repository.dart';
import 'package:anime_app/app/core/shared/anime/domain/usecases/search_anime.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AnimeLogic {
  static void binds(Injector i) {
    i.addLazySingleton<AnimeRepository>(
      () => AnimeRepositoryImpl(
        datasource: AnimetubeDatasourceImpl(
          requestService: i.get(),
        ),
      ),
    );
    i.addLazySingleton<SearchAnime>(
      () => SearchAnime(
        repository: i.get<AnimeRepository>(),
      ),
    );
  }
}
