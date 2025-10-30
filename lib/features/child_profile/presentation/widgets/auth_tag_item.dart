
import 'package:flutter/material.dart';

import '../../../../resorces/pallete.dart';

class TagItem extends StatelessWidget {
  final String name, subtitle;

  const TagItem({required this.name, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: Palette.bgBackground90,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0
        ,horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            Text(subtitle, style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400
            ,color: Palette.textMutedForeground)),
          ],
        ),
      ),
    );
  }
}