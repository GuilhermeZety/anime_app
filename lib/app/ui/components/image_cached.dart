import 'package:anime_app/app/core/common/services/image_cache_service.dart';
import 'package:anime_app/app/ui/components/shimed_box.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ImageCached extends StatefulWidget {
  const ImageCached({super.key, required this.url});

  final String url;

  @override
  State<ImageCached> createState() => _ImageCachedState();
}

class _ImageCachedState extends State<ImageCached> {
  bool loading = true;
  bool error = false;

  Uint8List? bytes;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var bytes = await ImageCacheService().getImage(widget.url);
      if (bytes != null) {
        this.bytes = bytes;
      } else {
        error = true;
      }
      loading = false;
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const ShimmedBox();
    }
    if (error || bytes == null) {
      return const SizedBox(
        width: 100,
        height: 100,
        child: Center(
          child: Icon(Icons.error),
        ),
      );
    }
    return Image.memory(
      bytes!,
      fit: BoxFit.cover,
    );
  }
}
