import 'package:anime_app/app/core/common/constants/app_colors.dart';
import 'package:anime_app/app/core/common/extensions/context_extension.dart';
import 'package:anime_app/app/core/shared/anime/anime_logic.dart';
import 'package:anime_app/app/core/shared/anime/domain/entities/anime_entity.dart';
import 'package:anime_app/app/core/shared/anime/presentation/components/anime_item.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
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
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
        _buildAnimes(),
      ],
    );
  }

  Widget _buildAnimes() {
    var qtd = ((context.width - 40) / 180).floor().abs();
    if (qtd > 6) {
      qtd = 6;
    }
    return SliverPadding(
      padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20, top: 20),
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