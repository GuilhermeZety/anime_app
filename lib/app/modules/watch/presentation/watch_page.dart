import 'package:anime_app/app/core/common/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class WatchPage extends StatefulWidget {
  const WatchPage({
    super.key,
    required this.link,
  });

  final String link;

  @override
  State<WatchPage> createState() => _WatchPageState();
}

class _WatchPageState extends State<WatchPage> {
  // Create a [Player] to control playback.
  late final player = Player();
  // Create a [VideoController] to handle video output from [Player].
  late final controller = VideoController(player);

  @override
  void initState() {
    super.initState();

    // Play a [Media] or [Playlist].
    player.open(
      Media(
        widget.link,
        httpHeaders: {
          'Content-Type': 'video/mp4',
          'Referer': 'https://www.anitube.vip/',
        },
      ),
    );
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: context.width,
        height: context.height,
        child: Video(
          controller: controller,
        ),
      ),
    );
  }
}
