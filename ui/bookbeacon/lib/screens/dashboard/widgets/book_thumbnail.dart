import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../utils/globals.dart';

class BookThumbnail extends StatelessWidget {
  const BookThumbnail({
    super.key, required this.thumbnailUrl, this.dimension = const Size(90, 126)
  });
  final String thumbnailUrl;
  final Size dimension;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: dimension.height,
        width: dimension.width,
        decoration: BoxDecoration(
          color:
              Globals.colorScheme.secondaryContainer,
        ),
        child: FastCachedImage(
          url: thumbnailUrl,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
