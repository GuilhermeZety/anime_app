import 'package:anime_app/app/core/common/constants/app_colors.dart';
import 'package:anime_app/app/core/common/extensions/widget_extension.dart';
import 'package:anime_app/app/ui/components/input.dart';
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
  @override
  Widget build(BuildContext context) {
    return ScaffoldGradientBackground(
      gradient: AppColors.backgrondGradient,
      body: Padding(
        padding: const EdgeInsets.only(top: 30, right: 30, left: 30),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  color: AppColors.grey_200,
                  onPressed: () => Modular.to.pop(),
                  icon: const Icon(Icons.arrow_back),
                ),
                const Gap(10),
                Input(
                  widget.controller,
                  keyboard: TextInputType.text,
                  hint: 'Search',
                  prefixIcon: const Icon(Icons.search),
                ).hero('search').expanded(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
