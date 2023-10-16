import 'package:anime_app/app/core/common/constants/app_constants.dart';
import 'package:anime_app/app/core/common/services/requests/request_service.dart';
import 'package:anime_app/app/core/shared/manga/data/datasources/datasource/manga_datasource.dart';
import 'package:anime_app/app/core/shared/manga/data/models/chapter_model.dart';
import 'package:anime_app/app/core/shared/manga/data/models/chapter_release_model.dart';
import 'package:anime_app/app/core/shared/manga/data/models/images_model.dart';
import 'package:anime_app/app/core/shared/manga/data/models/manga_model.dart';
import 'package:dio/dio.dart';
import 'package:html/parser.dart';

class MangaLivreDatasourceImpl extends MangaDatasource {
  final RequestService requestService;

  final dio = Dio();

  MangaLivreDatasourceImpl({required this.requestService});

  @override
  Future<List<MangaModel>> search(String value) async {
    final form = FormData.fromMap({'search': value});
    final response = await dio.post(
      AppConstants.search,
      options: Options(
        headers: {
          'X-Requested-With': 'XMLHttpRequest', // Corrigido o cabeçalho
          'Content-Type': 'multipart/form-data',
        },
      ),
      data: form,
    );

    List<MangaModel> listMangas = [];

    for (var manga in response.data['series']) {
      listMangas.add(MangaModel.fromMap(manga));
    }

    return listMangas;
  }

  @override
  Future<List<ChapterModel>> getChapters(int? page, int idSerie) async {
    final response = await requestService.post(
      '${AppConstants.baseUrl}/series/chapters_list.json?page=${page ?? 1}&id_serie=$idSerie',
      headers: {
        'X-Requested-With': 'XMLHttpRequest', // Corrigido o cabeçalho
      },
    );

    List<ChapterModel> listChapters = [];

    if (response.data['chapters'] == false) {
      return [];
    }
    for (var manga in response.data['chapters']) {
      listChapters.add(ChapterModel.fromMap(manga));
    }

    return listChapters;
  }

  @override
  Future<List<ImagesModel>> getImages(int idRelease) async {
    final response = await requestService.post(
      '${AppConstants.baseUrl}/leitor/pages/$idRelease.json',
      headers: {
        'X-Requested-With': 'XMLHttpRequest', // Corrigido o cabeçalho
      },
    );

    List<ImagesModel> listImages = [];

    for (var manga in response.data['images']) {
      listImages.add(ImagesModel.fromMap(manga));
    }

    return listImages;
  }

  @override
  Future<List<ChapterReleaseModel>> getReleasesMangas(int page) async {
    final response = await requestService.post(
      '${AppConstants.baseUrl}/home/releases?page=$page&type=manga',
      headers: {
        'X-Requested-With': 'XMLHttpRequest', // Corrigido o cabeçalho
      },
    );

    List<ChapterReleaseModel> listReleases = [];

    for (var manga in response.data['releases']) {
      listReleases.add(ChapterReleaseModel.fromMap(manga));
    }

    return listReleases;
  }

  @override
  Future<String> getDescription(String url) async {
    final response = await requestService.post(
      AppConstants.baseUrl + url,
      headers: {
        'X-Requested-With': 'XMLHttpRequest', // Corrigido o cabeçalho
      },
    );

    var document = parse(response.data);
    var description = document.querySelectorAll('.series-desc');
    int? lastIndex;
    String? resp = description.last.text;
    lastIndex = resp.lastIndexOf('.');

    if (lastIndex != -1) {
      String novoTexto = resp.substring(0, lastIndex + 1);
      return novoTexto.trimLeft().replaceAll(RegExp(r'\s+'), ' ');
    }

    return resp;
  }
}
