import 'package:anime_app/app/core/common/constants/app_colors.dart';
import 'package:anime_app/app/core/common/extensions/context_extension.dart';
import 'package:anime_app/app/core/common/extensions/widget_extension.dart';
import 'package:anime_app/app/modules/home/presentation/cubit/home_cubit.dart';
import 'package:anime_app/app/ui/dialogs/coming_soon_modal.dart';
import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gap/gap.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  final HomeCubit _cubit = Modular.get();
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
                separatorBuilder: () => const Gap(20),
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
                            backgroundColor: AppColors.red_400,
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
                  const Gap(60),
                  HomeDrawerItem(
                    selected: _cubit.controller.index == 0,
                    ontap: () {
                      _cubit.controller.animateTo(0);
                      if (mounted) setState(() {});
                    },
                    icon: Icons.home_rounded,
                    name: 'Inicio',
                  ),
                  HomeDrawerItem(
                    selected: _cubit.controller.index == 1,
                    icon: Icons.favorite_rounded,
                    name: 'Favoritos',
                    ontap: () {
                      _cubit.controller.animateTo(1);
                      if (mounted) setState(() {});
                    },
                  ),
                  HomeDrawerItem(
                    icon: Icons.calendar_month,
                    selected: _cubit.controller.index == 2,
                    name: 'Calendário',
                    ontap: () {
                      _cubit.controller.animateTo(2);
                      if (mounted) setState(() {});
                    },
                  ),
                  HomeDrawerItem(
                    selected: _cubit.controller.index == 3,
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

class HomeDrawerItem extends StatelessWidget {
  const HomeDrawerItem({
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
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.red,
      child: Text(name),
    ).expandedH();
  }
}
