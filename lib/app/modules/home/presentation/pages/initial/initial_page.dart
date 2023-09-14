import 'package:anime_app/app/core/common/constants/app_routes.dart';
import 'package:anime_app/app/core/common/extensions/widget_extension.dart';
import 'package:anime_app/app/core/shared/anime/presentation/components/episode_item.dart';
import 'package:anime_app/app/modules/home/presentation/pages/initial/cubit/initial_cubit.dart';
import 'package:anime_app/app/ui/components/input.dart';
import 'package:anime_app/app/ui/components/loader.dart';
import 'package:anime_app/app/ui/components/shimed_box.dart';
import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gap/gap.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  TextEditingController controller = TextEditingController();

  final InitialCubit _cubit = Modular.get<InitialCubit>();

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
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: SeparatedColumn(
              separatorBuilder: () => const Gap(20),
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Input(
                  controller,
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(left: 20, right: 10),
                    child: Icon(Icons.search_rounded),
                  ),
                  onSubmit: (_) => Modular.to.pushNamed(AppRoutes.search, arguments: controller),
                  hint: 'Insira o nome do anime',
                ).hero('search'),
                _buildReleases,
              ],
            ),
          ),
        );
      },
    );
  }

  Widget get _buildReleases => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '🔥 Lançamentos',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const Gap(10),
          SizedBox(
            height: 200,
            child: Builder(
              builder: (context) {
                if (_cubit.releasesLoading) {
                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, __) => const ShimmedBox(
                      height: 200,
                      width: 200,
                    ),
                    separatorBuilder: (_, __) => const Gap(10),
                    itemCount: 10,
                  );
                } else if (_cubit.releases.isNotEmpty) {
                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) => SizedBox(
                      width: 200,
                      height: 200,
                      child: EpisodeItem(anime: _cubit.releases[index]),
                    ),
                    separatorBuilder: (_, __) => const Gap(10),
                    itemCount: _cubit.releases.length,
                  );
                }
                return const Center(
                  child: Loader(),
                );
              },
            ),
          ),
        ],
      );
}
