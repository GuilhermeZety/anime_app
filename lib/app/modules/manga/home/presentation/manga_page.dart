import 'package:anime_app/app/core/common/constants/app_colors.dart';
import 'package:anime_app/app/core/common/constants/app_routes.dart';
import 'package:anime_app/app/core/common/extensions/context_extension.dart';
import 'package:anime_app/app/core/common/extensions/widget_extension.dart';
import 'package:anime_app/app/core/shared/manga/domain/entities/manga_entity.dart';
import 'package:anime_app/app/modules/manga/manga/presentation/cubit/manga_page_cubit.dart';
import 'package:anime_app/app/ui/components/button.dart';
import 'package:anime_app/app/ui/components/image_cached.dart';
import 'package:anime_app/app/ui/components/panel.dart';
import 'package:anime_app/app/ui/components/shimed_box.dart';
import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gap/gap.dart';

class MangaPage extends StatefulWidget {
  const MangaPage({super.key, required this.manga});

  final MangaEntity manga;

  @override
  State<MangaPage> createState() => _MangaPageState();
}

class _MangaPageState extends State<MangaPage> {
  final MangaPageCubit cubit = MangaPageCubit();

  @override
  void initState() {
    super.initState();
    cubit.init(widget.manga);

    cubit.scrollController.addListener(cubit.onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey_500,
      appBar: AppBar(
        backgroundColor: AppColors.grey_500,
        elevation: 0,
      ),
      body: BlocBuilder(
        bloc: cubit,
        builder: (context, state) {
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 1200,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  controller: cubit.scrollController,
                  child: Column(
                    children: [
                      Panel(
                        child: Column(
                          children: [
                            Builder(
                              builder: (context) {
                                if (context.isLandscape) {
                                  return Column(
                                    children: [
                                      Text(
                                        '${widget.manga.name}',
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
                                          _buildAnimeInfo(state is MangaPageLoading).expanded(),
                                        ],
                                      ),
                                    ],
                                  );
                                }
                                return Column(
                                  children: [
                                    Text(
                                      '${widget.manga.name}',
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
                                        _buildAnimeInfo(state is MangaPageLoading).expanded(),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                            if (context.isLandscape) ...[
                              const Gap(20),
                              Panel(
                                color: AppColors.grey_700,
                                child: _buildSinopisis(state is MangaPageLoading),
                              ),
                            ],
                          ],
                        ),
                      ),
                      Button(
                        onPressed: () async {
                          cubit.getMangaChaptersReverse(widget.manga);
                        },
                        child: const Text('reverse'),
                      ),
                      _buildMangas,
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget get _buildMangas {
    return Column(
      children: [
        ...cubit.listChapters?.map(
              (e) => Padding(
                padding: const EdgeInsets.all(3),
                child: Panel(
                  onTap: () {
                    Modular.to.pushNamed(
                      AppRoutes.read,
                      arguments: e.release?.scanId,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 75,
                              decoration: BoxDecoration(
                                color: AppColors.grey_500,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 10,
                                    offset: Offset(0, -1),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Center(
                                  child: Text(
                                    e.date ?? '',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Gap(10),
                            SizedBox(
                              width: context.width * 0.5,
                              child: Text(
                                e.chapterName ?? '',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ).expanded(),
                          ],
                        ).expanded(),
                        Text(
                          '${e.number}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ) ??
            [],
      ],
    );
  }

  Widget get _buildAnimeImage {
    return SizedBox(
      height: 300,
      width: 200,
      child: ImageCached(
        url: widget.manga.coverThumb ?? '',
        radius: 20,
      ),
    );
  }

  Widget _buildAnimeInfo(bool loading) {
    if (loading) {
      return SeparatedColumn(
        separatorBuilder: () => const Gap(14),
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: const [
          ShimmedBox(
            height: 23,
            width: 160,
          ),
          ShimmedBox(
            height: 23,
            width: 140,
          ),
          ShimmedBox(
            height: 23,
            width: 300,
          ),
          ShimmedBox(
            height: 23,
            width: 80,
          ),
        ],
      );
    }
    var mangadata = widget.manga;
    return SeparatedColumn(
      separatorBuilder: () => const Divider(),
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildItemData('Autor', mangadata.author ?? ''),
        _buildItemData('Score', mangadata.score ?? ''),
        _buildItemData('Está completo? ', mangadata.isComplete == true ? 'Sim' : 'Não'),
      ],
    );
  }

  Widget _buildItemData(String title, String data, {Color? colorData}) {
    return Row(
      children: [
        Text(
          '$title: ',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          data,
          style: TextStyle(color: colorData ?? AppColors.grey_200),
        ).expanded(),
      ],
    );
  }

  Widget _buildSinopisis(bool loading) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Sinopse',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(10),
        Builder(
          builder: (context) {
            if (loading) {
              return const ShimmedBox(
                height: 30,
              ).expandedH();
            }
            return Text(
              cubit.description ?? '',
              style: const TextStyle(
                fontSize: 10,
                color: AppColors.grey_200,
              ),
            );
          },
        ),
      ],
    );
  }
}
