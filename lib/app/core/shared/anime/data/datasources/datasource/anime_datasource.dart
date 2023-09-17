import 'package:anime_app/app/core/shared/anime/data/models/anime/anime_model.dart';
import 'package:anime_app/app/core/shared/anime/data/models/calendar_item_model.dart';
import 'package:anime_app/app/core/shared/anime/data/models/episode/episode_data_model.dart';
import 'package:anime_app/app/core/shared/anime/data/models/episode/episode_model.dart';
import 'package:anime_app/app/core/shared/anime/domain/entities/episode/episode_entity.dart';

abstract class AnimeDatasource {
  Future<List<AnimeModel>> search(String value);
  Future<List<EpisodeModel>> getReleases();
  Future<CalendarModel> getCalendar();
  Future<EpisodeDataModel> getEpisodeData(EpisodeEntity episode);
}
