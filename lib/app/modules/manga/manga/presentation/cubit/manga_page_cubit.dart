import 'package:anime_app/app/core/shared/manga/data/models/chapter_slime_model.dart';
import 'package:anime_app/app/core/shared/manga/domain/entities/manga_entity.dart';
import 'package:anime_app/app/core/shared/manga/domain/entities/manga_slime_entity.dart';
import 'package:anime_app/app/core/shared/manga/domain/usecases/get_chapters.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'manga_page_state.dart';

class MangaPageCubit extends Cubit<MangaPageState> {
  MangaPageCubit() : super(MangaPageInitial());

  final TextEditingController controller = TextEditingController();

  String? description;
  ChapterSlimeModel? chapter;
  MangaEntity? mangaEntity;
  int pagina = 1;
  bool reverse = false;
  List<BookTempCapsEntity> caps = [];
  // List<String> capsOriginal = [];
  List<BookTempCapsEntity> capsOriginalObj = [];

  Future init(MangaSlimeEntity manga) async {
    emit(MangaPageLoading());
    await getMangaChapters(manga, 1);
    // if (manga.link != '') {
    //   mangaEntity = manga;
    //   await getDescription(manga.link!);
    //   await getMangaChapters(manga, 1);
    // }
    emit(MangaPageInitial());
  }

  void search(String number) {
    emit(MangaPageLoading());
    if (number.isEmpty) {
      caps = capsOriginalObj;
      emit(MangaPageInitial());
      return;
    }
    List<BookTempCapsEntity> capsFiltered = [];
    for (var cap in capsOriginalObj) {
      if (cap.btcCap == (double.parse(number) - 1.0)) {
        capsFiltered.add(cap);
      }
    }
    caps = capsFiltered;
    emit(MangaPageInitial());
  }

  Future getMangaChapters(MangaSlimeEntity manga, int? page) async {
    emit(MangaPageLoading());

    if (manga.bookID != null) {
      chapter = await Modular.get<GetChapters>()(GetChaptersParams(idSerie: manga.bookID!, bookName: manga.bookName ?? '')).then((value) => value.fold((l) => null, (r) => r));
      capsOriginalObj = chapter?.bookInfo?.bookTemp?[0].bookTempCaps?.map((e) => e).toList() ?? [];
      caps = capsOriginalObj;
    }
    emit(MangaPageInitial());
  }
}
