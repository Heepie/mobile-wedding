import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile_wedding/util/const.dart';

/// Widget for displaying a single image (local or remote)
class SingleImage extends StatelessWidget {
  final String path;
  final bool isRemote;
  final bool isWidthBigger;
  final Alignment alignment;
  final bool isVideoThumbnail;
  final VoidCallback? onTap;

  const SingleImage({
    super.key,
    required this.path,
    required this.isRemote,
    required this.isWidthBigger,
    this.alignment = Alignment.center,
    this.isVideoThumbnail = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final content = AspectRatio(
      aspectRatio: widthBiggerRatio,
      child: isVideoThumbnail ? _buildVideoThumbnail() : _buildImage(),
    );

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: content);
    }
    return content;
  }

  Widget _buildVideoThumbnail() {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Positioned.fill(child: _buildImage()),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.5),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.play_arrow, color: Colors.white, size: 32),
        ),
      ],
    );
  }

  Widget _buildImage() {
    if (isRemote) {
      return CachedNetworkImage(
        imageUrl: path,
        fit: BoxFit.cover,
        alignment: alignment,
        filterQuality: FilterQuality.low,
        placeholder:
            (context, url) =>
                const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      );
    }
    return Image.asset(
      path,
      fit: BoxFit.cover,
      alignment: alignment,
      filterQuality: FilterQuality.low,
    );
  }
}
