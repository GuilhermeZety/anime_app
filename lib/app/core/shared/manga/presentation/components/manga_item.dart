import 'package:anime_app/app/core/common/constants/app_colors.dart';
import 'package:anime_app/app/core/common/constants/app_routes.dart';
import 'package:anime_app/app/core/common/extensions/context_extension.dart';
import 'package:anime_app/app/core/common/extensions/widget_extension.dart';
import 'package:anime_app/app/core/shared/manga/domain/entities/manga_slime_entity.dart';
import 'package:anime_app/app/ui/components/image_cached.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MangaItem extends StatefulWidget {
  const MangaItem({super.key, this.manga, this.page});

  final MangaSlimeEntity? manga;
  final int? page;

  @override
  State<MangaItem> createState() => _MangaItemState();
}

class _MangaItemState extends State<MangaItem> {
  @override
  void initState() {
    super.initState();
  }

  bool hooved = false;
  @override
  Widget build(BuildContext context) {
    // bool watched = false;
    if (widget.manga != null) {
      // watched = AnimeLogic.getAnimeWatchEps(widget.anime!.uuid).where((element) => element['ep'] == widget.episode.uuid).isNotEmpty;
    }
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
          // print(widget.manga?.chapters?.first.number.toString());
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
        onTap: () async {
          Modular.to.pushNamed(AppRoutes.manga, arguments: widget.manga);
        },
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              // color: watched ? AppColors.grey_400 : null,
            ),
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
                          child: widget.manga?.bookImage != null ? ImageCached(url: widget.manga!.bookImage!) : const Center(child: Text('Sem imagem!')),
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
                      // Positioned(
                      //   left: 10,
                      //   bottom: 10,
                      //   child: Row(
                      //     children: [
                      //       ...widget.manga!.chapters!.map(
                      //         (e) => GestureDetector(
                      //           onTap: () => print(e.number),
                      //           child: Tag(
                      //             text: 'EP ${e.number}',
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Positioned(
                      //   right: 10,
                      //   top: 10,
                      //   child: Tag(
                      //     text: 'EP ${widget.manga?.chapters?[0].number}',
                      //   ),
                      // ),
                    ],
                  ),
                ).expanded(),
                SizedBox(
                  height: 50,
                  width: context.width,
                  child: Padding(
                    padding: const EdgeInsets.all(
                      10,
                    ),
                    child: AutoSizeText(
                      widget.manga?.bookNameOriginal ?? '',
                      maxLines: 2,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: AppColors.grey_200,
                        fontWeight: FontWeight.bold,
                        fontSize: context.isLandscape ? 14 : 12,
                      ),
                    ),
                  ),
                ).tooltip(widget.manga?.bookNameOriginal ?? ''),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
