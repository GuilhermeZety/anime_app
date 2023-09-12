import 'dart:developer';

import 'package:anime_app/app/core/common/constants/app_colors.dart';
import 'package:anime_app/app/core/common/extensions/context_extension.dart';
import 'package:anime_app/app/core/common/extensions/widget_extension.dart';
import 'package:anime_app/app/core/shared/anime/domain/entities/anime_entity.dart';
import 'package:anime_app/app/core/shared/anime/domain/usecases/search_anime.dart';
import 'package:anime_app/app/modules/search/presentation/components/anime_item.dart';
import 'package:anime_app/app/ui/components/input_search.dart';
import 'package:anime_app/app/ui/components/shimed_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gap/gap.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, required this.controller});

  final TextEditingController controller;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<AnimeEntity> animes = [];
  bool loading = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var response = await Modular.get<SearchAnime>()(SearchAnimeParams(value: widget.controller.text));

      response.fold((l) {
        log(l.toString());
      }, (r) {
        loading = false;
        animes = r;
        if (mounted) setState(() {});
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldGradientBackground(
      gradient: AppColors.backgrondGradient,
      body: Padding(
        padding: const EdgeInsets.only(top: 30, right: 30, left: 30),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            _buildSearch(),
            _buildAnimes(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearch() {
    return SliverPadding(
      padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
      sliver: SliverList.list(
        children: [
          Row(
            children: [
              IconButton(
                color: AppColors.grey_200,
                onPressed: () => Modular.to.pop(),
                icon: const Icon(Icons.arrow_back),
              ),
              const Gap(10),
              InputSearch(
                widget.controller,
                searchAction: (_) async {
                  //TODO: Logic to search
                },
                hint: 'Insira o nome do anime',
                prefixIcon: const Icon(Icons.search),
              ).hero('search').expanded(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnimes() {
    var qtd = ((context.width - 40) / 150).floor().abs();
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
          if (loading)
            ...List.generate(
              qtd * 3,
              (index) => const ShimmedBox(),
            )
          else
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
