import 'package:anime_app/app/core/common/constants/app_colors.dart';
import 'package:anime_app/app/core/common/constants/app_routes.dart';
import 'package:anime_app/app/core/common/extensions/widget_extension.dart';
import 'package:anime_app/app/core/common/features/usecases/usecase.dart';
import 'package:anime_app/app/core/shared/anime/domain/entities/episode_entity.dart';
import 'package:anime_app/app/core/shared/anime/domain/usecases/get_releases.dart';
import 'package:anime_app/app/ui/components/input.dart';
import 'package:anime_app/app/ui/components/loader.dart';
import 'package:anime_app/app/ui/components/shimed_box.dart';
import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gap/gap.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
            child: FutureBuilder(
              future: Modular.get<GetReleases>()(NoParams()).then((value) => value.fold((l) => <EpisodeEntity>[], (r) => r)),
              builder: (context, value) {
                if (value.connectionState == ConnectionState.waiting) {
                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, __) => const ShimmedBox(
                      height: 200,
                      width: 150,
                    ),
                    separatorBuilder: (_, __) => const Gap(10),
                    itemCount: 10,
                  );
                }
                if (value.connectionState == ConnectionState.done && value.hasData) {
                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) => Container(
                      height: 200,
                      width: 150,
                      color: AppColors.grey_300,
                      child: Center(
                        child: Text(
                          value.data?[index].name ?? '',
                          style: const TextStyle(
                            color: AppColors.grey_500,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    separatorBuilder: (_, __) => const Gap(10),
                    itemCount: value.data!.length,
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
