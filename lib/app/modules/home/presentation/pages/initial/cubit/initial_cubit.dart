import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'initial_state.dart';

class InitialCubit extends Cubit<InitialState> {
  InitialCubit() : super(InitialInitial());

  bool releasesLoading = true;

  // List<EpisodeEntity> releases = [];

  StreamSubscription? _streamSubscriptionReleases;

  Future init() async {
    await getReleases();
  }

  Future refresh() async {
    _streamSubscriptionReleases?.cancel();
    // releases = [];

    await getReleases();
  }

  Future getReleases() async {
    // if (releases.isEmpty) {
    //   releasesLoading = true;
    //   setState();
    // }
    // var stream = await Modular.get<GetReleases>()(NoParams()).then(
    //   (value) => value.fold(
    //     (l) => const Stream<List<EpisodeEntity>>.empty(),
    //     (r) => r,
    //   ),
    // );

    // _streamSubscriptionReleases = stream.listen((event) {
    //   releases = event;
    //   releasesLoading = false;
    //   setState();
    // });
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
