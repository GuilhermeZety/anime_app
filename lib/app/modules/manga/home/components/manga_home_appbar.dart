import 'package:anime_app/app/core/common/constants/app_colors.dart';
import 'package:anime_app/app/ui/dialogs/coming_soon_modal.dart';
import 'package:flutter/material.dart';

class MangaHomeAppbar extends StatefulWidget implements PreferredSizeWidget {
  const MangaHomeAppbar({super.key});

  @override
  State<MangaHomeAppbar> createState() => _MangaHomeAppbarState();

  @override
  Size get preferredSize => const Size(double.infinity, 80);
}

class _MangaHomeAppbarState extends State<MangaHomeAppbar> {
  void _openNotifications() {
    ComingSoonModal.show(context);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leadingWidth: 200,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20, top: 10),
        child: Row(
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                return MouseRegion(
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
                );
              },
            ),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20, top: 10),
          child: Row(
            children: [
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
        ),
      ],
    );
  }
}
