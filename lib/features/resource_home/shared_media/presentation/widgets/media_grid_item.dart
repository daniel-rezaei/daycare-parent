
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../resorces/pallete.dart';
import 'package:flutter_svg/flutter_svg.dart';


class MediaGridItem extends StatelessWidget {
  final MediaItem item;

  const MediaGridItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: item.isVideo
              ? _buildVideoThumbnail()
              : _buildImageThumbnail(),
        ),

        // فقط برای ویدیو
        if (item.isVideo)
          Positioned(
            top: 6,
            right: 6,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                'assets/images/ic_media.svg', // ← آیکون مخصوص ویدیو
                width: 20,
                height: 20,
              ),
            ),
          ),

        // Tag
        Positioned(
          bottom: 6,
          left: 6,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Palette.bgColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              item.tag,
              style: const TextStyle(
                fontSize: 12,
                color: Palette.txtPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImageThumbnail() {
    return CachedNetworkImage(
      imageUrl: item.thumbnailPath ?? item.imagePath,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      errorWidget: (_, __, ___) => Container(
        color: Colors.grey[300],
        child: const Icon(Icons.image_not_supported),
      ),
    );
  }

  Widget _buildVideoThumbnail() {
    return Stack(
      children: [
        // هرچی داری را نمایش بده
        CachedNetworkImage(
          imageUrl: item.thumbnailPath ?? item.imagePath,  // اگر Directus thumbnail بده
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          errorWidget: (_, __, ___) => Container(
            color: Colors.black12,
            child: const Icon(Icons.videocam, size: 40),
          ),
        ),

        // می‌تونی placeholder بزاری اگر thumbnail نیست
      ],
    );
  }
}


class MediaItem {
  final String imagePath;
  final String tag;
  final String createdAt;
  final bool isLocked;
  final bool isVideo;
  final String? thumbnailPath;
  final String? caption;
  final List<String>? privacy;
  final String? role;

  MediaItem({
    required this.imagePath,
    required this.tag,
    required this.createdAt,
    this.isLocked = false,
    required this.isVideo,
    this.privacy,
    this.thumbnailPath,
    this.caption,
    this.role,
  });
}

