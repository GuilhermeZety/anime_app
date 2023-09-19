import 'dart:developer';

import 'package:anime_app/app/core/common/constants/app_routes.dart';
import 'package:anime_app/app/core/common/enums/video_quality_enum.dart';
import 'package:anime_app/app/core/common/integrations/animetube.dart';
import 'package:anime_app/app/core/shared/anime/anime_logic.dart';
import 'package:anime_app/app/core/shared/anime/domain/entities/anime/anime_entity.dart';
import 'package:anime_app/app/core/shared/anime/domain/entities/episode/episode_data_entity.dart';
import 'package:anime_app/app/core/shared/anime/domain/entities/episode/episode_entity.dart';
import 'package:anime_app/app/core/shared/anime/domain/usecases/get_episode_data.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'watch_anime_state.dart';

class WatchAnimeCubit extends Cubit<WatchAnimeState> {
  WatchAnimeCubit() : super(WatchAnimeLoading());

  AnimeEntity? anime;
  int? page;
  late EpisodeEntity episode;
  EpisodeDataEntity? episodeData;

  int qualityLimit = 1;

  VideoQualityEnum quality = VideoQualityEnum.sd;

  Future init(EpisodeEntity ep, AnimeEntity? anim, int? pg) async {
    episode = ep;
    anime = anim;
    page = pg;

    episodeData = await Modular.get<GetEpisodeData>()(GetEpisodeDataParams(episode: episode)).then((value) => value.fold((l) => null, (r) => r));
    if (episodeData != null) {
      quality = episodeData!.quality;
      switch (episodeData!.quality) {
        case VideoQualityEnum.fullhd:
          qualityLimit = 3;
        case VideoQualityEnum.hd:
          qualityLimit = 2;
        case VideoQualityEnum.sd:
          qualityLimit = 1;
      }
    }
    log('contains 2 ${episodeData!.containsTwo.toString()}');

    emit(WatchAnimeSelectQuality());
  }

  void changeQuality(VideoQualityEnum quality) {
    emit(WatchAnimeStt());
    this.quality = quality;
    emit(WatchAnimeSelectQuality());
  }

  Future watch() async {
    Modular.to.pushNamed(
      AppRoutes.watch,
      arguments: 'https://ikaros.anicdn.net/${Anitube().getResolution(quality, episodeData?.containsTwo ?? false)}/${episode.uuid}.mp4',
    );

    if (anime != null && page != null) {
      await AnimeLogic.setWatchEps(
        episode: episode,
        anime: anime!,
        page: page!,
      );
    }
    // launchUrl(Uri.parse(Anitube().watch(episode.uuid, quality, episodeData?.containsTwo ?? false)));
  }
}
