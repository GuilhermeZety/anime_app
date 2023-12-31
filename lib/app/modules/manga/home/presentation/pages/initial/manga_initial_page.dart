import 'package:anime_app/app/core/common/constants/app_colors.dart';
import 'package:anime_app/app/core/common/constants/app_routes.dart';
import 'package:anime_app/app/core/common/extensions/context_extension.dart';
import 'package:anime_app/app/core/common/extensions/widget_extension.dart';
import 'package:anime_app/app/core/shared/manga/presentation/components/chapter_item.dart';
import 'package:anime_app/app/modules/manga/home/presentation/pages/initial/cubit/manga_initial_cubit.dart';
import 'package:anime_app/app/ui/components/input.dart';
import 'package:anime_app/app/ui/components/shimed_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MangaInitialPage extends StatefulWidget {
  const MangaInitialPage({super.key});

  @override
  State<MangaInitialPage> createState() => _MangaInitialPageState();
}

class _MangaInitialPageState extends State<MangaInitialPage> {
  TextEditingController controller = TextEditingController();

  final MangaInitialCubit _cubit = Modular.get<MangaInitialCubit>();

  @override
  void initState() {
    super.initState();
    _cubit.init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _cubit,
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async {
            await _cubit.refresh();
          },
          backgroundColor: AppColors.pink_400,
          color: AppColors.grey_600,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              _buildSearch(),
              ..._buildReleases(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSearch() {
    return SliverAppBar(
      pinned: true,
      floating: true,
      leading: const SizedBox(),
      backgroundColor: AppColors.grey_700.withOpacity(0.5),
      elevation: 0,
      expandedHeight: 90,
      collapsedHeight: 90,
      flexibleSpace: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Input(
              controller,
              prefixIcon: const Padding(
                padding: EdgeInsets.only(left: 20, right: 10),
                child: Icon(Icons.search_rounded),
              ),
              onSubmit: (_) => Modular.to.pushNamed(AppRoutes.mangaSearch, arguments: controller),
              hint: 'Insira o nome do manga',
            ).hero('search'),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildReleases() {
    var qtd = ((context.width - 40) / (context.isLandscape ? 250 : 210)).floor().abs();
    if (qtd > 6) {
      qtd = 6;
    }
    if (qtd == 0) {
      qtd = 1;
    }
    return [
      SliverPadding(
        padding: const EdgeInsets.only(right: 20, left: 20, bottom: 10, top: 20),
        sliver: SliverList.list(
          children: const [
            Text(
              '🔥 Lançamentos',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      SliverPadding(
        padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
        sliver: SliverGrid.count(
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: qtd,
          childAspectRatio: 9 / 16,
          children: [
            if (_cubit.releasesLoading)
              ...List.generate(
                qtd * 3,
                (index) => const ShimmedBox(),
              )
            else
              ..._cubit.releases
                  .map(
                    (e) => ChapterItem(manga: e, initial: true).animate().fade(),
                  )
                  .toList(),
          ],
        ),
      ),
    ];
  }
}
