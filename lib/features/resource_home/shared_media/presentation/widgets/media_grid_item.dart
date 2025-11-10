
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../resorces/pallete.dart';

class MediaGridItem extends StatelessWidget {
  final MediaItem item;

  const MediaGridItem({required this.item});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            item.imagePath,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Positioned(
          top: 6,
          right: 6,
          child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
              ),
              child: SvgPicture.asset('assets/images/ic_media.svg')
          ),
        ),
        Positioned(
          bottom: 6,
          left: 6,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Palette.bgColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              item.tag,
              style: TextStyle(
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
}
class MediaItem {
  final String imagePath;
  final String tag;
  final String date;

  MediaItem(this.imagePath, this.tag, this.date);
}