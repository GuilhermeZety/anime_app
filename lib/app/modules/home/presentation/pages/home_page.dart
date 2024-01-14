import 'package:anime_app/app/core/common/constants/app_colors.dart';
import 'package:anime_app/app/core/common/extensions/context_extension.dart';
import 'package:anime_app/app/core/common/extensions/widget_extension.dart';
import 'package:anime_app/app/modules/home/presentation/components/bottom_bar.dart';
import 'package:anime_app/app/modules/home/presentation/components/home_appbar.dart';
import 'package:anime_app/app/modules/home/presentation/components/home_drawer.dart';
import 'package:anime_app/app/modules/home/presentation/cubit/home_cubit.dart';
import 'package:anime_app/app/modules/home/presentation/pages/favorites/favorites_page.dart';
import 'package:anime_app/app/modules/home/presentation/pages/initial/initial_page.dart';
import 'package:anime_app/app/ui/components/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final HomeCubit _cubit = Modular.get();
  @override
  void initState() {
    _cubit.controller = TabController(length: 3, vsync: this);

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
    return PopScope(
      canPop: false,
      child: BlocBuilder<HomeCubit, HomeState>(
        bloc: _cubit,
        builder: (context, state) {
          if (context.isLandscape) {
            return ScaffoldGradientBackground(
              gradient: AppColors.backgrondGradient,
              body: Row(
                children: [
                  const HomeDrawer().animate().slideX(begin: -0.8, end: 0),
                  _content.expanded(),
                ],
              ),
            );
          }
          return ScaffoldGradientBackground(
            appBar: const HomeAppbar(),
            gradient: AppColors.backgrondGradient,
            bottomNavigationBar: const BottomBar(),
            body: _content,
          );
        },
      ),
    );
  }

  Widget get _content => TabBarView(
        controller: _cubit.controller,
        children: [
          const InitialPage(),
          const FavoritesPage(),
          // const CalendarPage(),
          // const Center(child: ComingSoon()),
          Button(onPressed: () async => Modular.to.navigate('/manga_home/'), child: const Text('Manga')),
        ],
      );
}
