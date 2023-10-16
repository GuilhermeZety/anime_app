import 'package:anime_app/app/core/shared/manga/data/models/chapter_model.dart';
import 'package:anime_app/app/core/shared/manga/data/models/chapter_release_model.dart';
import 'package:anime_app/app/core/shared/manga/data/models/images_model.dart';
import 'package:anime_app/app/core/shared/manga/data/models/manga_model.dart';

abstract class MangaDatasource {
  Future<List<MangaModel>> search(String value);
  Future<List<ChapterModel>> getChapters(int? page, int idSerie);
  Future<List<ImagesModel>> getImages(int idRelease);
  Future<List<ChapterReleaseModel>> getReleasesMangas(int page);
  Future<String> getDescription(String url);
}
