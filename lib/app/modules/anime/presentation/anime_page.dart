import 'package:anime_app/app/core/shared/anime/domain/entities/anime/anime_entity.dart';
import 'package:flutter/material.dart';

class AnimePage extends StatefulWidget {
  const AnimePage({super.key, required this.anime});

  final AnimeEntity anime;

  @override
  State<AnimePage> createState() => _AnimePageState();
}

class _AnimePageState extends State<AnimePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(widget.anime.name ?? ''),
      ),
    );
  }
}
