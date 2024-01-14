import 'package:anime_app/app/core/shared/animes/data/datasources/datasource/anime_datasource_impl.dart';
import 'package:anime_app/app/core/shared/animes/data/repositories/anime_repository_impl.dart';
import 'package:anime_app/app/core/shared/animes/domain/repositories/anime_repository.dart';
import 'package:anime_app/app/core/shared/animes/domain/usecases/search_anime.dart';
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
    i.addLazySingleton<GetAnimes>(
      () => GetAnimes(
        repository: i.get<AnimeRepository>(),
      ),
    );
  }
}
