import 'package:anime_app/app/core/common/constants/app_colors.dart';
import 'package:anime_app/app/core/common/constants/app_routes.dart';
import 'package:anime_app/app/core/common/extensions/context_extension.dart';
import 'package:anime_app/app/core/common/extensions/widget_extension.dart';
import 'package:anime_app/app/core/shared/manga/domain/entities/manga_slime_entity.dart';
import 'package:anime_app/app/modules/manga/manga/presentation/cubit/manga_page_cubit.dart';
import 'package:anime_app/app/ui/components/button.dart';
import 'package:anime_app/app/ui/components/image_cached.dart';
import 'package:anime_app/app/ui/components/input.dart';
import 'package:anime_app/app/ui/components/panel.dart';
import 'package:anime_app/app/ui/components/shimed_box.dart';
import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class MangaPage extends StatefulWidget {
  const MangaPage({super.key, required this.manga});

  final MangaSlimeEntity manga;

  @override
  State<MangaPage> createState() => _MangaPageState();
}

class _MangaPageState extends State<MangaPage> {
  final MangaPageCubit cubit = MangaPageCubit();

  @override
  void initState() {
    super.initState();
    cubit.init(widget.manga);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey_500,
      appBar: AppBar(
        backgroundColor: AppColors.grey_500,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: BlocBuilder(
          bloc: cubit,
          builder: (context, state) {
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 1200,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
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
                                        '${widget.manga.bookNameOriginal}',
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
                                      '${widget.manga.bookNameOriginal}',
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
                      // Button(
                      //   onPressed: () async {
                      //     cubit.getMangaChaptersReverse(widget.manga);
                      //   },
                      //   child: const Text('reverse'),
                      // ),
                      const Gap(20),
                      Panel(
                        child: Column(
                          children: [
                            Input(
                              label: 'Procurar capítulo:',
                              cubit.controller,
                              onChange: (value) => cubit.search(cubit.controller.text),
                            ),
                            const Gap(20),
                            const Panel(
                              width: 200,
                              color: AppColors.grey_400,
                              child: Center(
                                child: Text(
                                  'CAPÍTULOS',
                                  style: TextStyle(fontSize: 24),
                                ),
                              ),
                            ),
                            const Gap(20),
                            SizedBox(
                              width: context.width * 0.9,
                              height: 400,
                              child: _buildManga,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String cutInt(String cap) {
    if (cap.endsWith('.0')) {
      return cap.substring(0, cap.length - 2);
    }
    return cap;
  }

  Widget get _buildManga {
    var qtd = ((context.width - 40) / (context.isLandscape ? 250 : 210)).floor().abs();
    if (qtd > 6) {
      qtd = 6;
    }
    if (qtd == 0) {
      qtd = 1;
    }
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: qtd, crossAxisSpacing: 5, mainAxisSpacing: 5, mainAxisExtent: 100),
      itemCount: cubit.caps.length,
      itemBuilder: (BuildContext context, int index) {
        // var item = cubit.chapter?.bookInfo?.bookTemp?[0].bookTempCaps;
        var date = DateTime.parse(cubit.caps[index].btcDateUpdated.toString());
        var hoje = DateTime.now();
        var dateCap = DateFormat('dd/MM/yyyy').format(date);
        return Padding(
          padding: const EdgeInsets.all(3),
          child: Panel(
            color: AppColors.grey_300,
            onTap: () {
              Modular.to.pushNamed(
                AppRoutes.read,
                arguments: {'cap': cubit.caps[index].btcCap, 'mangaID': cubit.chapter?.mangaId, 'capList': cubit.capsOriginalObj},
              );
            },
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    (date.day == hoje.day && date.month == hoje.month && date.year == hoje.year) ? 'Hoje' : dateCap,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Cap: ${cutInt(((cubit.caps[index].btcCap)! + 1.0).toString())}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget get _buildAnimeImage {
    return SizedBox(
      height: 300,
      width: 200,
      child: ImageCached(
        url: widget.manga.bookImage ?? '',
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
    // var mangadata = widget.manga;
    return SeparatedColumn(
      separatorBuilder: () => const Divider(),
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: const [
        // _buildItemData('Autor', mangadata.author ?? ''),
        // _buildItemData('Score', mangadata.score ?? ''),
        // _buildItemData('Está completo? ', mangadata.isComplete == true ? 'Sim' : 'Não'),
      ],
    );
  }

  // ignore: unused_element
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
              cubit.chapter?.bookInfo?.bookSinopsis ?? '',
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
