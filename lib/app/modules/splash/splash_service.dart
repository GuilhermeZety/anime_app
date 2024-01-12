// ignore_for_file: use_build_context_synchronously

import 'package:anime_app/app/core/common/utils/toasting.dart';
import 'package:flutter/material.dart';

class SplashService {
  Future<void> navigate(BuildContext context) async {
    try {
      // if (await Modular.get<ConnectionService>().isConnected) {
      //   Future.delayed(3.seconds, () => Modular.to.navigate(AppRoutes.home));
      //   return;
      // }
      // Future.delayed(1.seconds, () => Modular.to.navigate(AppRoutes.notConnection));
      return;
    } catch (err) {
      Toasting.error(context, message: err.toString());
    }
  }
}
