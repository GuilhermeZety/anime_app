import 'package:anime_app/app/core/shared/anime/data/models/anime_model.dart';
import 'package:anime_app/app/core/shared/anime/data/models/calendar_item_model.dart';
import 'package:anime_app/app/core/shared/anime/data/models/episode_model.dart';

abstract class AnimeDatasource {
  Future<List<AnimeModel>> search(String value);
  Future<List<EpisodeModel>> getReleases();
  Future<CalendarModel> getCalendar();
}
