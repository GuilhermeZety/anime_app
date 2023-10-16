import 'package:anime_app/app/core/shared/manga/data/datasources/datasource/manga_livre_datasource_impl.dart';
import 'package:anime_app/app/core/shared/manga/data/repositories/manga_repository_impl.dart';
import 'package:anime_app/app/core/shared/manga/domain/repositories/manga_repository.dart';
import 'package:anime_app/app/core/shared/manga/domain/usecases/get_chapters.dart';
import 'package:anime_app/app/core/shared/manga/domain/usecases/get_description.dart';
import 'package:anime_app/app/core/shared/manga/domain/usecases/get_images.dart';
import 'package:anime_app/app/core/shared/manga/domain/usecases/get_releases_mangas.dart';
import 'package:anime_app/app/core/shared/manga/domain/usecases/search_manga.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MangaLogic {
  static void binds(Injector i) {
    i.addLazySingleton<MangaRepository>(
      () => MangaRepositoryImpl(
        datasource: MangaLivreDatasourceImpl(
          requestService: Modular.get(),
        ),
      ),
    );
    i.addLazySingleton<SearchManga>(
      () => SearchManga(
        repository: i.get<MangaRepository>(),
      ),
    );
    i.addLazySingleton<GetChapters>(
      () => GetChapters(
        repository: i.get<MangaRepository>(),
      ),
    );
    i.addLazySingleton<GetImages>(
      () => GetImages(
        repository: i.get<MangaRepository>(),
      ),
    );
    i.addLazySingleton<GetReleasesMangas>(
      () => GetReleasesMangas(
        repository: i.get<MangaRepository>(),
      ),
    );
    i.addLazySingleton<GetDescription>(
      () => GetDescription(
        repository: i.get<MangaRepository>(),
      ),
    );
  }
}
