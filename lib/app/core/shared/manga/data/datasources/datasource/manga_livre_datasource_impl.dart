import 'dart:convert';

import 'package:anime_app/app/core/common/constants/app_constants.dart';
import 'package:anime_app/app/core/common/services/requests/request_service.dart';
import 'package:anime_app/app/core/shared/manga/data/datasources/datasource/manga_datasource.dart';
import 'package:anime_app/app/core/shared/manga/data/models/chapter_slime_model.dart';
import 'package:anime_app/app/core/shared/manga/data/models/manga_slime_model.dart';
import 'package:dio/dio.dart';
import 'package:html/parser.dart';

class MangaLivreDatasourceImpl extends MangaDatasource {
  final RequestService requestService;

  final dio = Dio();

  MangaLivreDatasourceImpl({required this.requestService});

  Future<String> getNextData() async {
    var response = await requestService.get('https://slimeread.com/');
    if (response.data != null) {
      var document = parse(response.data);
      // print(document.body?.outerHtml);
      var next = document.querySelector('#__NEXT_DATA__');
      var json = jsonDecode(next?.text ?? '');
      return json['buildId'];
    }
    return '';
  }

  @override
  Future<List<MangaSlimeModel>> search(String value) async {
    final response = await requestService.get(
      'https://slimeread.com/api/book/search?query=$value',
      headers: {
        'Content-Type': 'application/json',
      },
    );
    // final form = FormData.fromMap({'search': value});
    // final response = await dio.post(
    //   AppConstants.search,
    //   options: Options(
    //     headers: {
    //       'X-Requested-With': 'XMLHttpRequest', // Corrigido o cabeçalho
    //       'Content-Type': 'multipart/form-data',
    //     },
    //   ),
    //   data: form,
    // );
    if (response.statusCode != 200 || response.data == null) {
      return [];
    }
    List<MangaSlimeModel> mangas = [];
    for (var manga in response.data) {
      if (manga != null) {
        var resp = MangaSlimeModel.fromMap(manga);
        mangas.add(resp);
      }
    }
    return mangas;
    // for (var manga in response.data['series']) {
    // listMangas.add(MangaModel.fromMap(manga));
    // }
  }

  @override
  Future<ChapterSlimeModel> getChapters(String bookName, int idSerie) async {
    // final response = await requestService.post(
    //   '${AppConstants.baseUrl}/series/chapters_list.json?page=${page ?? 1}&id_serie=$idSerie',
    //   headers: {
    //     'X-Requested-With': 'XMLHttpRequest', // Corrigido o cabeçalho
    //   },
    // );

    // if (response.data['chapters'] == false) {
    //   return [];
    // }
    // for (var manga in response.data['chapters']) {
    //   listChapters.add(ChapterModel.fromMap(manga));
    // }
    var next = await getNextData();
    final response = await requestService.get(
      'https://slimeread.com/_next/data/$next/manga/$idSerie/$bookName.json?book_id=$idSerie&book_id=$bookName',
    );
    var manga = ChapterSlimeModel.fromMap(response.data['pageProps']);
    return manga;
  }

  @override
  Future<List<String>> getImages(int mangaId, String cap) async {
    List<String> images = [];
    final response = await requestService.get(
      'https://apiv2.slimeread.com:8443/book_cap_units?manga_id=$mangaId&cap=$cap',
    );
    // final response = await requestService.post(
    //   '${AppConstants.baseUrl}/leitor/pages/$idRelease.json',
    //   headers: {
    //     'X-Requested-With': 'XMLHttpRequest', // Corrigido o cabeçalho
    //   },
    // );

    // List<ImagesModel> listImages = [];

    // for (var manga in response.data['images']) {
    //   listImages.add(ImagesModel.fromMap(manga));
    // }
    if (response.data != null) {
      List maps = response.data['book_temp'][0]['book_temp_caps'][0]['book_temp_cap_unit'];
      for (var image in maps) {
        images.add('https://objects.slimeread.com/${image['btcu_image']}');
      }
    }

    return images;
  }

  @override
  Future<List<BookInfoModel>> getReleasesMangas(int page) async {
    // final response = await requestService.post(
    //   '${AppConstants.baseUrl}/home/releases?page=$page&type=manga',
    //   headers: {
    //     'X-Requested-With': 'XMLHttpRequest', // Corrigido o cabeçalho
    //   },
    // );

    // List<ChapterReleaseModel> listReleases = [];

    // for (var manga in response.data['releases']) {
    //   listReleases.add(ChapterReleaseModel.fromMap(manga));
    // }

    // return listReleases;
    var next = await getNextData();
    final response = await requestService.get(
      'https://slimeread.com/_next/data/$next/index.json',
    );
    List maps = response.data['pageProps']['books'];
    List<BookInfoModel> listReleases = [];
    for (var i = 0; i < 100; i++) {
      Map<String, dynamic> manga = {};
      manga = {
        'book_name_original': maps[i]['book_name_original'],
        'book_name': maps[i]['book_name'],
        'book_image': (maps[i]['book_image'] as String).replaceAll(' ', '%20'),
        'book_id': maps[i]['book_id'],
        'book_tag': maps[i]['book_tag'],
        'book_date_created': maps[i]['book_date_created'],
        'book_categories': maps[i]['book_categories'],
        'book_temp': maps[i]['book_temp'],
        'nsfw': maps[i]['nsfw'],
      };
      BookInfoModel model = BookInfoModel.fromMap(manga);

      listReleases.add(model);
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
