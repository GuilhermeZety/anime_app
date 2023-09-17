import 'package:anime_app/app/core/common/constants/app_colors.dart';
import 'package:anime_app/app/core/common/extensions/context_extension.dart';
import 'package:anime_app/app/core/common/extensions/widget_extension.dart';
import 'package:anime_app/app/core/shared/anime/domain/entities/anime/anime_entity.dart';
import 'package:anime_app/app/core/shared/anime/domain/usecases/get_anime_data.dart';
import 'package:anime_app/app/ui/components/image_cached.dart';
import 'package:anime_app/app/ui/components/panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gap/gap.dart';

class AnimePage extends StatefulWidget {
  const AnimePage({super.key, required this.anime});

  final AnimeEntity anime;

  @override
  State<AnimePage> createState() => _AnimePageState();
}

class _AnimePageState extends State<AnimePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var data = await Modular.get<GetAnimeData>()(GetAnimeDataParams(anime: widget.anime, page: 1)).then((value) => value.fold((l) => null, (r) => r));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 1200,
      ),
      child: Scaffold(
        backgroundColor: AppColors.grey_500,
        appBar: AppBar(
          backgroundColor: AppColors.grey_500,
          elevation: 0,
          title: Text(widget.anime.name ?? ''),
        ),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 1200,
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Panel(
                    child: Builder(
                      builder: (context) {
                        if (context.isLandscape) {
                          return Column(
                            children: [
                              Text(
                                '${widget.anime.name}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Gap(10),
                              Row(
                                children: [
                                  _buildAnimeImage,
                                  const Gap(20),
                                  _buildAnimeInfo,
                                ],
                              ),
                            ],
                          );
                        }
                        return Column(
                          children: [
                            Text(
                              '${widget.anime.name}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Gap(10),
                            _buildAnimeImage,
                            const Gap(20),
                            Row(
                              children: [
                                _buildAnimeInfo,
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  const Gap(20),
                  const Panel().expanded(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget get _buildAnimeImage {
    return SizedBox(
      height: 200,
      width: 200,
      child: ImageCached(
        url: widget.anime.image ?? '',
        radius: 20,
      ).hero(widget.anime.uuid),
    );
  }

  Widget get _buildAnimeInfo {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Gap(10),
      ],
    );
  }
}
