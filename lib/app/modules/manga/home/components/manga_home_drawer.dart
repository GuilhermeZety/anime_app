import 'package:anime_app/app/core/common/constants/app_colors.dart';
import 'package:anime_app/app/core/common/extensions/color_extension.dart';
import 'package:anime_app/app/core/common/extensions/context_extension.dart';
import 'package:anime_app/app/core/common/extensions/widget_extension.dart';
import 'package:anime_app/app/modules/manga/home/presentation/cubit/manga_home_cubit.dart';
import 'package:anime_app/app/ui/dialogs/coming_soon_modal.dart';
import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gap/gap.dart';

class MangaHomeDrawer extends StatefulWidget {
  const MangaHomeDrawer({super.key});

  @override
  State<MangaHomeDrawer> createState() => _MangaHomeDrawerState();
}

class _MangaHomeDrawerState extends State<MangaHomeDrawer> {
  final MangaHomeCubit _cubit = Modular.get();
  void _openNotifications() {
    ComingSoonModal.show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.grey_500,
      height: context.height,
      width: context.width * 0.2,
      constraints: const BoxConstraints(
        maxWidth: 400,
        minWidth: 300,
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: BlocBuilder(
            bloc: _cubit,
            builder: (context, state) {
              return SeparatedColumn(
                separatorBuilder: () => const Gap(10),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            ComingSoonModal.show(context);
                          },
                          child: Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1000),
                              color: Colors.white.withOpacity(0.2),
                            ),
                          ),
                        ),
                      ),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: _openNotifications,
                          child: const Badge(
                            smallSize: 12,
                            backgroundColor: AppColors.pink_400,
                            textColor: AppColors.white,
                            child: Icon(
                              Icons.notifications_rounded,
                              color: AppColors.grey_200,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(80),
                  MangaHomeDrawerItem(
                    selected: _cubit.controller.index == 0,
                    ontap: () {
                      _cubit.controller.animateTo(0);
                      if (mounted) setState(() {});
                    },
                    icon: Icons.home_rounded,
                    name: 'Inicio',
                  ),
                  MangaHomeDrawerItem(
                    selected: _cubit.controller.index == 1,
                    icon: Icons.favorite_rounded,
                    name: 'Favoritos',
                    ontap: () {
                      _cubit.controller.animateTo(1);
                      if (mounted) setState(() {});
                    },
                  ),
                  MangaHomeDrawerItem(
                    selected: _cubit.controller.index == 2,
                    icon: Icons.person,
                    name: 'Perfil',
                    ontap: () {
                      _cubit.controller.animateTo(3);
                      if (mounted) setState(() {});
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class MangaHomeDrawerItem extends StatelessWidget {
  const MangaHomeDrawerItem({
    super.key,
    required this.name,
    required this.ontap,
    required this.icon,
    required this.selected,
  });

  final String name;
  final IconData icon;
  final void Function() ontap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? AppColors.pink_400.withOpacity(0.1) : Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: ontap,
        splashColor: AppColors.pink_400.withOpacity(0.2),
        overlayColor: AppColors.pink_400.withOpacity(0.1).toMaterialStateProperty(),
        child: Container(
          height: 45,
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    color: selected ? AppColors.pink_400 : AppColors.grey_200,
                  ),
                  const Gap(10),
                  Text(name),
                ],
              ),
              if (selected)
                Container(
                  width: 5,
                  height: 30,
                  decoration: const BoxDecoration(
                    color: AppColors.pink_400,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                    ),
                  ),
                ),
            ],
          ),
        ).expandedH(),
      ),
    );
  }
}
