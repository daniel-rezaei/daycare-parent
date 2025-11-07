
import 'package:flutter/material.dart';

import '../../../../resorces/pallete.dart';

class TagItem extends StatelessWidget {
  final String name, subtitle;

  const TagItem({required this.name, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140, // عرض کوچکتر برای جا شدن بیشتر
      decoration: BoxDecoration(
        color: Palette.bgBackground90,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12), // padding کمتر
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Palette.textMutedForeground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
