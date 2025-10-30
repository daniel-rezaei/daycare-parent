
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../resorces/pallete.dart';

class InfoCard extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final bool fullWidth;

  const InfoCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.fullWidth = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: fullWidth ? double.infinity : null,
      height: 150,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Palette.bgBackground90,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(icon),
          SizedBox(height: 8),
          Text(title,
              style:
              TextStyle(fontWeight: FontWeight.w600, fontSize: 16,color:
              Palette.textForeground)),
          SizedBox(height: 4),
          Text(subtitle, style: TextStyle(fontSize: 14,
              fontWeight: FontWeight.w400,
          color: Palette.textSecondaryForeground80)),
        ],
      ),
    );
  }
}