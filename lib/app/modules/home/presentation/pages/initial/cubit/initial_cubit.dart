import 'dart:async';

import 'package:anime_app/app/core/common/features/usecases/usecase.dart';
import 'package:anime_app/app/core/shared/anime/domain/entities/episode_entity.dart';
import 'package:anime_app/app/core/shared/anime/domain/usecases/get_releases.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'initial_state.dart';

class InitialCubit extends Cubit<InitialState> {
  InitialCubit() : super(InitialInitial());

  bool releasesLoading = true;

  List<EpisodeEntity> releases = [];

  StreamSubscription? _streamSubscriptionReleases;

  Future init() async {
    await getReleases();
  }

  Future refresh() async {
    _streamSubscriptionReleases?.cancel();
    releases = [];

    await getReleases();
  }

  Future getReleases() async {
    if (releases.isEmpty) {
      releasesLoading = true;
      setState();
    }
    var stream = await Modular.get<GetReleases>()(NoParams()).then(
      (value) => value.fold(
        (l) => const Stream<List<EpisodeEntity>>.empty(),
        (r) => r,
      ),
    );

    _streamSubscriptionReleases = stream.listen((event) {
      releases = event;
      releasesLoading = false;
      setState();
    });
  }

  void setState() {
    if (state is InitialSetState) {
      emit(InitialSetState());
    } else {
      emit(InitialInitial());
      emit(InitialSetState());
    }
    emit(InitialInitial());
  }
}
