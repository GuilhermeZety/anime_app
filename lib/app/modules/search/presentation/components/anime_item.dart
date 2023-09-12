import 'dart:io';

import 'package:anime_app/app/core/shared/anime/domain/entities/anime_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AnimeItem extends StatelessWidget {
  const AnimeItem({super.key, required this.anime});

  final AnimeEntity anime;

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid || Platform.isIOS) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          anime.image ?? '',
          fit: BoxFit.cover,
        ),
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: _image(
        Container(),
      ),
    );
  }

  Widget _image(Widget child) {
    {
      return Stack(
        children: [
          if (Platform.isAndroid || Platform.isIOS)
            Positioned.fill(
              child: CachedNetworkImage(
                imageUrl: anime.image ?? '',
                fit: BoxFit.cover,
              ),
            )
          else
            Positioned.fill(
              child: Image.network(
                anime.image ?? '',
                fit: BoxFit.cover,
              ),
            ),
          Positioned.fill(child: child),
        ],
      );
    }
  }
}
