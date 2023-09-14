import 'package:anime_app/app/core/common/extensions/entities_extension.dart';
import 'package:anime_app/app/core/shared/anime/data/datasources/datasource/animetube_datasource_impl.dart';
import 'package:anime_app/app/core/shared/anime/data/models/anime_model.dart';
import 'package:anime_app/app/core/shared/anime/data/models/episode_model.dart';
import 'package:anime_app/app/core/shared/anime/data/repositories/anime_repository_impl.dart';
import 'package:anime_app/app/core/shared/anime/domain/entities/anime_entity.dart';
import 'package:anime_app/app/core/shared/anime/domain/entities/episode_entity.dart';
import 'package:anime_app/app/core/shared/anime/domain/repositories/anime_repository.dart';
import 'package:anime_app/app/core/shared/anime/domain/usecases/get_releases.dart';
import 'package:anime_app/app/core/shared/anime/domain/usecases/search_anime.dart';
import 'package:anime_app/main.dart';
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
    i.addLazySingleton<GetReleases>(
      () => GetReleases(
        repository: i.get<AnimeRepository>(),
      ),
    );
  }

  static const String key = 'favorite_anime';
  static const String releasesKey = 'releases';

  static List<AnimeEntity> getAllFavoriteAnime() {
    var response = session.prefs.getStringList(key);

    if (response == null) return [];

    var map = response.map((e) => AnimeModel.fromJson(e)).toList();

    return map;
  }

  static AnimeEntity? getFavoriteAnime(String uuid) {
    var response = session.prefs.getStringList(key);

    if (response == null) return null;

    var map = response.map((e) => AnimeModel.fromJson(e)).toList();

    return map.where((element) => element.uuid == uuid).firstOrNull;
  }

  static Future<void> setFavoriteAnime(AnimeEntity anime) async {
    var favorited = getFavoriteAnime(anime.uuid);

    if (favorited != null) {
      var all = getAllFavoriteAnime();

      all.removeWhere((element) => element.uuid == anime.uuid);

      await session.prefs.setStringList(
        key,
        all.map((e) => e.as<AnimeModel>().toJson()).toList(),
      );
    } else {
      var all = getAllFavoriteAnime();

      all.add(anime);

      await session.prefs.setStringList(
        key,
        all.map((e) => e.as<AnimeModel>().toJson()).toList(),
      );
    }
  }

  static Future<void> setAllReleases(List<EpisodeEntity> releases) async {
    await session.prefs.setStringList(
      releasesKey,
      releases.map((e) => e.as<EpisodeModel>().toJson()).toList(),
    );
  }

  static List<EpisodeModel> getAllReleases() {
    var response = session.prefs.getStringList(releasesKey);

    if (response == null) return [];

    var map = response.map((e) => EpisodeModel.fromJson(e)).toList();

    return map;
  }
}
