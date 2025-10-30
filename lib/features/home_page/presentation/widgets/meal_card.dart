import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:parent_app/resorces/style.dart';

import '../../../../resorces/pallete.dart';

class MealContainer extends StatelessWidget {
  final String title;
  final String subtitle;
  final String icon;

  const MealContainer({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Palette.bgBackground90,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(icon, width: 48, height: 52),
          const SizedBox(height: 8),
          Text(
            title,
            style: AppTypography.textTheme.titleLarge?.copyWith(
              color: Palette.textForeground,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          if (subtitle.isNotEmpty)
            Text(
              subtitle[0].toUpperCase() + subtitle.substring(1),
              style: AppTypography.textTheme.bodyLarge?.copyWith(
                color: Palette.textMutedForeground,
              ),
              textAlign: TextAlign.center,
              softWrap: true,
            ),
        ],
      ),
    );
  }
}

