
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../resorces/pallete.dart';

class SectionEmergency extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? icon;
  final Color? iconColor;
  final List<Widget> items;
  final VoidCallback? onTitleTap; // اضافه شد

  const SectionEmergency({
    required this.title,
    this.subtitle,
    this.icon,
    this.iconColor,
    required this.items,
    this.onTitleTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Palette.bgBackground90,
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector( // تیتر کلیک شدنی شد
              onTap: onTitleTap,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8)),
                  color: Palette.bgBackground80,
                ),
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        if (icon != null)
                          Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: SvgPicture.asset(icon!),
                          ),
                        Text(
                          title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ],
                    ),
                    if (subtitle != null)
                      Text(
                        subtitle!,
                        style: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            ...items, // آیتم ها
          ],
        ),
      ),
    );
  }
}
