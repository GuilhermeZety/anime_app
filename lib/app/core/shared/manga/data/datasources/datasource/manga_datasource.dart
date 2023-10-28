import 'package:anime_app/app/core/shared/manga/data/models/chapter_slime_model.dart';
import 'package:anime_app/app/core/shared/manga/data/models/manga_slime_model.dart';

abstract class MangaDatasource {
  Future<List<MangaSlimeModel>> search(String value);
  Future<ChapterSlimeModel> getChapters(String bookName, int idSerie);
  Future<List<String>> getImages(int mangaId, String cap);
  Future<List<BookInfoModel>> getReleasesMangas(int page);
  Future<String> getDescription(String url);
}
