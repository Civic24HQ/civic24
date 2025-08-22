import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:styles/styles.dart';

class AppCachedImage extends StatelessWidget {
  const AppCachedImage({this.imageUrl, super.key});
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      httpHeaders: const {'User-Agent': 'Civic24/1.0'},
      fit: BoxFit.cover,
      imageUrl: imageUrl!,
      progressIndicatorBuilder: (context, url, progress) {
        return Padding(
          padding: const EdgeInsetsGeometry.all(AppDimensions.size120),
          child: CircularProgressIndicator(value: progress.progress, color: context.primary),
        );
      },
      errorWidget: (context, url, error) => const SizedBox.shrink(),
    );
  }
}
