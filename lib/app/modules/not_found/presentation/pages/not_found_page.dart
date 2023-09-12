import 'package:anime_app/app/core/common/constants/app_assets.dart';
import 'package:anime_app/app/core/common/constants/app_colors.dart';
import 'package:anime_app/app/core/common/constants/app_routes.dart';
import 'package:anime_app/app/core/common/extensions/context_extension.dart';
import 'package:anime_app/app/core/common/extensions/widget_extension.dart';
import 'package:anime_app/app/ui/components/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';

class NotFoundPage extends StatefulWidget {
  const NotFoundPage({super.key});

  @override
  State<NotFoundPage> createState() => _NotFoundPageState();
}

class _NotFoundPageState extends State<NotFoundPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldGradientBackground(
      gradient: AppColors.backgrondGradient,
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600),
            alignment: Alignment.center,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Gap(10),
                Column(
                  children: [
                    Container(
                      width: context.width - 40,
                      height: context.width - 40,
                      constraints: const BoxConstraints(maxWidth: 300, maxHeight: 300),
                      child: SvgPicture.asset(AppAssets.notFound),
                    ),
                    const Text(
                      'Página não encontrada!',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    const Gap(10),
                    const Text(
                      'Esta página não existe ou foi removida. Verifique o endereço digitado ou volte para a página inicial.',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Button.secondary(
                  onPressed: () async => Modular.to.pushNamedAndRemoveUntil(
                    AppRoutes.splash,
                    (_) => false,
                  ),
                  child: const Text('VOLTAR PARA A TELA INICIAL'),
                ).expandedH(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
