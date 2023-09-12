import 'package:anime_app/app/core/shared/anime/data/models/anime_model.dart';

abstract class AnimeDatasource {
  Future<List<AnimeModel>> search(String value);
}
