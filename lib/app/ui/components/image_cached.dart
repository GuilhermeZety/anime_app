import 'dart:io';

import 'package:anime_app/app/core/common/constants/app_colors.dart';
import 'package:anime_app/app/core/common/extensions/widget_extension.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageCached extends StatelessWidget {
  const ImageCached({super.key, required this.url, this.radius, this.file, this.fit = BoxFit.cover});

  final String? url;
  final double? radius;
  final File? file;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(radius ?? 10),
          child: Builder(
            builder: (context) {
              if (file != null) {
                return Image.file(
                  file!,
                  fit: fit,
                );
              }
              return FastCachedImage(
                url: url ?? '',
                loadingBuilder: (context, data) => Container(
                  constraints: constraints,
                  color: AppColors.grey_200,
                ).shim(),
                errorBuilder: (context, data, stacktrace) => Container(
                  constraints: constraints,
                  child: const Center(
                    child: Text(
                      'SEM\nIMAGEM',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.grey_500,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
                fit: fit,
              );
            },
          ),
        );
      },
    );
  }
}
