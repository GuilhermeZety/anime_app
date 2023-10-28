import 'dart:async';

import 'package:anime_app/app/core/common/services/requests/request_service.dart';
import 'package:anime_app/app/core/shared/manga/data/models/chapter_slime_model.dart';
import 'package:anime_app/app/core/shared/manga/domain/usecases/get_releases_mangas.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'manga_initial_state.dart';

class MangaInitialCubit extends Cubit<MangaInitialState> {
  MangaInitialCubit() : super(MangaInitialInitial());

  bool releasesLoading = true;

  List<BookInfoModel> releases = [];
  final RequestService requestService = Modular.get();

  Future init() async {
    await getReleases();
  }

  Future refresh() async {
    releases = [];
    await getReleases();
    // await getChapters(null, 2624);
  }

  // Future<List<ChapterModel>> getChapters(int? page, int idSerie) async {
  //   // final response = await requestService.post(
  //   //   '${AppConstants.baseUrl}/series/chapters_list.json?page=${page ?? 1}&id_serie=$idSerie',
  //   //   headers: {
  //   //     'X-Requested-With': 'XMLHttpRequest', // Corrigido o cabeçalho
  //   //   },
  //   // );

  //   // if (response.data['chapters'] == false) {
  //   //   return [];
  //   // }
  //   // for (var manga in response.data['chapters']) {
  //   //   listChapters.add(ChapterModel.fromMap(manga));
  //   // }
  //   var next = await getNextData();
  //   final response = await requestService.get(
  //     'https://slimeread.com/_next/data/$next/ler/$idSerie/cap-0.json?id=$idSerie&id=cap-0',
  //   );
  //   log(response.data['pageProps']['book_info']['book_synopsis']);
  //   return [];
  // }

  // Future<String> getNextData() async {
  //   var response = await requestService.get('https://slimeread.com/');
  //   if (response.data != null) {
  //     var document = parse(response.data);
  //     // print(document.body?.outerHtml);
  //     var next = document.querySelector('#__NEXT_DATA__');
  //     var json = jsonDecode(next?.text ?? '');
  //     return json['buildId'];
  //   }
  //   return '';
  // }

  Future getReleases() async {
    if (releases.isEmpty) {
      releasesLoading = true;
      setState();
    }
    var resp = await Modular.get<GetReleasesMangas>()(GetReleasesMangasParams(page: 1)).then(
      (value) => value.fold(
        (l) => null,
        (r) => r,
      ),
    );
    releases = resp ?? [];

    releasesLoading = false;
    setState();
  }

  void setState() {
    if (state is MangaInitialSetState) {
      emit(MangaInitialSetState());
    } else {
      emit(MangaInitialInitial());
      emit(MangaInitialSetState());
    }
    emit(MangaInitialInitial());
  }
}
