import 'package:flutter/material.dart';
import 'package:anime_app/app/core/common/constants/app_colors.dart';

class CustomCheckbox extends StatelessWidget {
  const CustomCheckbox({super.key, this.value, this.size = 50, required this.onSelect});

  final bool? value;
  final double size;
  final Function onSelect;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelect(),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: value != null ? (value! ? AppColors.purple_400 : AppColors.pink_400) : AppColors.grey_300,
          borderRadius: BorderRadius.circular(size * 0.25),
        ),
        child: Center(
          child: value != null
              ? value!
                  ? Icon(
                      Icons.close_rounded,
                      size: size * 0.8,
                      weight: 3,
                    )
                  : Icon(
                      Icons.circle_outlined,
                      size: size * 0.8,
                    )
              : null,
        ),
      ),
    );
  }
}
