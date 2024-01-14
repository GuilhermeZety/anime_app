import 'package:anime_app/app/core/shared/animes/data/models/anime_model.dart';

abstract class AnimeDatasource {
  Future<List<AnimeModel>> getAnimes(String? value, int page);
}
