import 'package:anime_app/app/core/common/constants/app_colors.dart';
import 'package:anime_app/app/core/common/extensions/context_extension.dart';
import 'package:anime_app/app/core/shared/anime/anime_logic.dart';
import 'package:anime_app/app/core/shared/anime/domain/entities/anime/anime_entity.dart';
import 'package:anime_app/app/core/shared/anime/presentation/components/anime_item.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  bool isLoading = true;
  List<AnimeEntity> animes = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      loadAnimes();
    });
    super.initState();
  }

  void loadAnimes() {
    animes = AnimeLogic.getAllFavoriteAnime();
    isLoading = false;
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const SizedBox();
    }
    if (animes.isEmpty) {
      return const Center(
        child: Text(
          'Nenhum anime favorito',
          style: TextStyle(
            fontSize: 20,
            color: AppColors.grey_200,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        _buildTitle(),
        _buildAnimes(),
      ],
    );
  }

  Widget _buildTitle() => SliverPadding(
        padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20, top: 20),
        sliver: SliverList.list(
          children: const [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.favorite,
                      color: AppColors.pink_400,
                      size: 20,
                    ),
                    Gap(5),
                    Text(
                      'Favoritos',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );

  Widget _buildAnimes() {
    var qtd = ((context.width - 40) / 150).floor().abs();
    if (qtd > 6) {
      qtd = 6;
    }
    if (qtd == 0) {
      qtd = 1;
    }
    return SliverPadding(
      padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20, top: 0),
      sliver: SliverGrid.count(
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: qtd,
        children: [
          // if (loading)
          //   ...List.generate(
          //     qtd * 3,
          //     (index) => const ShimmedBox(),
          //   )
          // else
          ...animes
              .map(
                (e) => AnimeItem(anime: e),
              )
              .toList(),
        ],
      ),
    );
  }
}
