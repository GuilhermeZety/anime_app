import 'package:anime_app/app/core/common/services/connection/connection_service.dart';
import 'package:anime_app/app/core/common/services/connection/ping_connection_service_impl.dart';
import 'package:anime_app/app/core/common/services/requests/dio_request_service.dart';
import 'package:anime_app/app/core/common/services/requests/request_service.dart';
import 'package:anime_app/app/modules/home/home_module.dart';
import 'package:anime_app/app/modules/not_connection/presenter/not_connection_page.dart';
import 'package:anime_app/app/modules/not_found/presentation/pages/not_found_page.dart';
import 'package:anime_app/app/modules/splash/presentation/pages/splash_page.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton<ConnectionService>(() => PingConnectionServiceImpl());
    i.addSingleton<RequestService>(() => DioRequestService());
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (args) => const SplashPage(),
      transition: TransitionType.fadeIn,
    );
    r.child(
      '/not_connection/',
      child: (args) => const NotConnectionPage(),
      transition: TransitionType.fadeIn,
    );
    r.module(
      '/home/',
      module: HomeModule(),
      transition: TransitionType.fadeIn,
      duration: 700.ms,
    );
    r.wildcard(child: (args) => const NotFoundPage());
  }
}
