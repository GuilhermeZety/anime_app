import 'package:anime_app/app/core/common/constants/app_colors.dart';
import 'package:anime_app/app/core/common/extensions/context_extension.dart';
import 'package:anime_app/app/core/common/extensions/widget_extension.dart';
import 'package:anime_app/app/core/shared/anime/domain/entities/episode_entity.dart';
import 'package:anime_app/app/ui/components/image_cached.dart';
import 'package:anime_app/app/ui/components/tag.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class EpisodeItem extends StatefulWidget {
  const EpisodeItem({super.key, required this.episode});

  final EpisodeEntity episode;

  @override
  State<EpisodeItem> createState() => _EpisodeItemState();
}

class _EpisodeItemState extends State<EpisodeItem> {
  bool hooved = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        hooved = true;
        if (mounted) setState(() {});
      },
      onExit: (_) {
        hooved = false;
        if (mounted) setState(() {});
      },
      child: GestureDetector(
        onTapDown: (_) {
          hooved = true;
          if (mounted) setState(() {});
        },
        onTapUp: (_) {
          hooved = false;
          if (mounted) setState(() {});
        },
        onTapCancel: () {
          hooved = false;
          if (mounted) setState(() {});
        },
        onTap: () {
          //TODO: logic to access Episode
        },
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            transform: hooved ? (Matrix4.identity()..scale(0.98)) : Matrix4.identity(),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Padding(
                          padding: const EdgeInsets.all(1),
                          child: ImageCached(url: widget.episode.image ?? ''),
                        ),
                      ),
                      Positioned.fill(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                if (hooved) ...<Color>[
                                  Colors.transparent,
                                  AppColors.grey_600.withOpacity(0.2),
                                  AppColors.grey_600.withOpacity(0.7),
                                  AppColors.grey_600,
                                ] else ...[
                                  Colors.transparent,
                                  AppColors.grey_600.withOpacity(0.2),
                                  AppColors.grey_600.withOpacity(0.5),
                                  AppColors.grey_600,
                                ],
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ),
                      if (widget.episode.duration != null)
                        Positioned(
                          left: 10,
                          top: 10,
                          child: Tag(
                            text: widget.episode.duration!,
                          ),
                        ),
                      Positioned(
                        right: 10,
                        top: 10,
                        child: Tag(
                          text: 'EP ${widget.episode.episode}',
                        ),
                      ),
                    ],
                  ),
                ).expanded(),
                SizedBox(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(
                      10,
                    ),
                    child: AutoSizeText(
                      widget.episode.name ?? '',
                      maxLines: 2,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: AppColors.grey_200,
                        fontWeight: FontWeight.bold,
                        fontSize: context.isLandscape ? 14 : 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
