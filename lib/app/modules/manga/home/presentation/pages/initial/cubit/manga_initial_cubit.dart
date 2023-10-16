import 'dart:async';

import 'package:anime_app/app/core/shared/manga/domain/entities/chapter_release_entity.dart';
import 'package:anime_app/app/core/shared/manga/domain/usecases/get_releases_mangas.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'manga_initial_state.dart';

class MangaInitialCubit extends Cubit<MangaInitialState> {
  MangaInitialCubit() : super(MangaInitialInitial());

  bool releasesLoading = true;

  List<ChapterReleaseEntity> releases = [];

  Future init() async {
    await getReleases();
  }

  Future refresh() async {
    releases = [];

    await getReleases();
  }

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
