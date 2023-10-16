import 'package:anime_app/app/modules/manga/home/presentation/pages/manga_home_page.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:anime_app/app/modules/manga/home/presentation/cubit/manga_home_cubit.dart';
import 'package:anime_app/app/modules/manga/home/presentation/pages/initial/cubit/manga_initial_cubit.dart';

class MangaHomeModule extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton<MangaHomeCubit>(() => MangaHomeCubit());
    i.addLazySingleton<MangaInitialCubit>(() => MangaInitialCubit());
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (args) => const MangaHomePage(),
      transition: TransitionType.fadeIn,
      duration: 700.ms,
    );
  }
}
