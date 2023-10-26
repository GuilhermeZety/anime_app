import 'package:anime_app/app/core/common/constants/app_colors.dart';
import 'package:anime_app/app/core/common/extensions/context_extension.dart';
import 'package:anime_app/app/core/common/extensions/widget_extension.dart';
import 'package:anime_app/app/modules/manga/home/components/manga_bottom_bar.dart';
import 'package:anime_app/app/modules/manga/home/components/manga_home_appbar.dart';
import 'package:anime_app/app/modules/manga/home/components/manga_home_drawer.dart';
import 'package:anime_app/app/modules/manga/home/presentation/cubit/manga_home_cubit.dart';
import 'package:anime_app/app/modules/manga/home/presentation/pages/initial/manga_initial_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';

class MangaHomePage extends StatefulWidget {
  const MangaHomePage({super.key});

  @override
  State<MangaHomePage> createState() => _MangaHomePageState();
}

class _MangaHomePageState extends State<MangaHomePage> with SingleTickerProviderStateMixin {
  final MangaHomeCubit _cubit = Modular.get();
  @override
  void initState() {
    _cubit.controller = TabController(length: 1, vsync: this);

    _cubit.controller.addListener(_cubit.onTabControllerChange);
    super.initState();
  }

  @override
  void dispose() {
    _cubit.controller.removeListener(_cubit.onTabControllerChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocBuilder<MangaHomeCubit, MangaHomeState>(
        bloc: _cubit,
        builder: (context, state) {
          if (context.isLandscape) {
            return ScaffoldGradientBackground(
              gradient: AppColors.backgrondGradient,
              appBar: null,
              body: Row(
                children: [
                  const MangaHomeDrawer().animate().slideX(begin: -0.8, end: 0),
                  _content.expanded(),
                ],
              ),
            );
          }
          return ScaffoldGradientBackground(
            appBar: context.isLandscape ? null : const MangaHomeAppbar(),
            gradient: AppColors.backgrondGradient,
            bottomNavigationBar: const MangaBottomBar(),
            body: _content,
          );
        },
      ),
    );
  }

  Widget get _content => TabBarView(
        controller: _cubit.controller,
        children: const [
          MangaInitialPage(),
          // Aloalo(),
        ],
      );
}
