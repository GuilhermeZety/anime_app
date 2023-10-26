import 'dart:developer';

import 'package:anime_app/app/core/common/constants/app_colors.dart';
import 'package:anime_app/app/core/common/constants/app_routes.dart';
import 'package:anime_app/app/core/common/extensions/context_extension.dart';
import 'package:anime_app/app/core/common/extensions/widget_extension.dart';
import 'package:anime_app/app/core/shared/manga/data/models/chapter_slime_model.dart';
import 'package:anime_app/app/core/shared/manga/domain/entities/chapter_release_entity.dart';
import 'package:anime_app/app/core/shared/manga/domain/usecases/get_chapters.dart';
import 'package:anime_app/app/ui/components/image_cached.dart';
import 'package:anime_app/app/ui/components/tag.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ChapterItem extends StatefulWidget {
  const ChapterItem({super.key, this.manga, this.page});

  final ChapterReleaseEntity? manga;
  final int? page;

  @override
  State<ChapterItem> createState() => _ChapterItemState();
}

class _ChapterItemState extends State<ChapterItem> {
  String? imagem;
  int? cap;

  @override
  void initState() {
    super.initState();
    if (widget.manga?.chapters?.isNotEmpty == true) {
      cap = widget.manga?.idSerie;
    }

    if (widget.manga != null && widget.manga!.image != null && widget.manga!.image!.contains('static')) {
      imagem = widget.manga!.imageThumb;
    } else {
      imagem = null;
    }
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
          if (cap != null) {
            ChapterSlimeModel? resp = await Modular.get<GetChapters>()(GetChaptersParams(bookName: '', idSerie: cap!)).then((value) => value.fold((l) => null, (r) => r));
            Modular.to.pushNamed(AppRoutes.read, arguments: resp?.mangaId);
          }
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
                          child: imagem != null ? ImageCached(url: widget.manga!.imageThumb!) : const Center(child: Text('Sem imagem!')),
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
                      Positioned(
                        left: 10,
                        bottom: 10,
                        child: Row(
                          children: [
                            ...widget.manga!.chapters!.map(
                              (e) => GestureDetector(
                                onTap: () => log(e.number.toString()),
                                child: Tag(
                                  text: 'EP ${e.number}',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: 10,
                        top: 10,
                        child: Tag(
                          text: 'EP ${widget.manga?.chapters?[0].number}',
                        ),
                      ),
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
                      widget.manga?.name ?? '',
                      maxLines: 2,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: AppColors.grey_200,
                        fontWeight: FontWeight.bold,
                        fontSize: context.isLandscape ? 14 : 12,
                      ),
                    ),
                  ),
                ).tooltip(widget.manga?.name ?? ''),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
