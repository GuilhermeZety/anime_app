import 'package:anime_app/app/core/shared/manga/domain/entities/chapter_entity.dart';
import 'package:anime_app/app/core/shared/manga/domain/entities/manga_entity.dart';
import 'package:anime_app/app/core/shared/manga/domain/usecases/get_chapters.dart';
import 'package:anime_app/app/core/shared/manga/domain/usecases/get_description.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:html/parser.dart';

part 'manga_page_state.dart';

class MangaPageCubit extends Cubit<MangaPageState> {
  MangaPageCubit() : super(MangaPageInitial());

  final ScrollController scrollController = ScrollController();

  String? description;
  List<ChapterEntity>? listChapters;
  MangaEntity? mangaEntity;
  int pagina = 1;
  bool reverse = false;

  Future init(MangaEntity manga) async {
    emit(MangaPageLoading());
    if (manga.link != '') {
      mangaEntity = manga;
      await getDescription(manga.link!);
      await getMangaChapters(manga, 1);
    }
    emit(MangaPageInitial());
  }

  Future getDescription(String link) async {
    emit(MangaPageLoading());

    description = await Modular.get<GetDescription>()(GetDescriptionParams(url: link)).then((value) => value.fold((l) => null, (r) => r));
    emit(MangaPageInitial());
  }

  Future getMangaChapters(MangaEntity manga, int? page) async {
    emit(MangaPageLoading());

    if (manga.idSerie != null) {
      listChapters = await Modular.get<GetChapters>()(GetChaptersParams(idSerie: manga.idSerie!, page: page)).then((value) => value.fold((l) => null, (r) => r));
    }
    emit(MangaPageInitial());
  }

  Future getMangaChaptersReverse(MangaEntity manga) async {
    emit(MangaPageLoading());

    if (manga.idSerie != null) {
      List<ChapterEntity> list = [];
      var index = int.parse(listChapters!.first.number!).ceil();
      for (var i = 0; i < index; i++) {
        listChapters = await Modular.get<GetChapters>()(GetChaptersParams(idSerie: manga.idSerie!, page: i)).then((value) => value.fold((l) => null, (r) => r));
        if (listChapters != null) {
          list = listChapters!;
        } else {
          listChapters = list;
          reverse = true;
          listChapters?.sort((a, b) => double.parse(a.number ?? '0').compareTo(double.parse(b.number ?? '0')));
          emit(MangaPageInitial());
          return;
        }
      }
    }
    emit(MangaPageInitial());
  }

  void onScroll() async {
    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent) {
      pagina = pagina + 1;
      if (mangaEntity != null) {
        var resp = await Modular.get<GetChapters>()(GetChaptersParams(idSerie: mangaEntity!.idSerie!, page: pagina)).then((value) => value.fold((l) => null, (r) => r));
        if (resp != null) {
          listChapters?.addAll(resp);
          listChapters?.sort((a, b) => double.parse(b.number ?? '0').compareTo(double.parse(a.number ?? '0')));
          emit(MangaPageLoading());
          emit(MangaPageInitial());
        }
      }
      // O usuário chegou ao fim da tela
      // Faça a lógica desejada quando o usuário chegar ao fim da tela.
    }
  }
}
