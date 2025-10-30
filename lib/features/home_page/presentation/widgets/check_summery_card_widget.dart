import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../resorces/pallete.dart';

class CheckInSummaryCard extends StatelessWidget {
  const CheckInSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 14),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heart and "cheerful!"
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                children: [
                  SvgPicture.asset('assets/images/ic_heart.svg'),
                  SizedBox(height: 4),
                  Text(
                    textAlign: TextAlign.center,
                    " cheerful!",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16),
            Container(
              width: 5,
              height: 64,
              color: Palette.borderInput,
              margin: EdgeInsets.symmetric(horizontal: 8),
            ),
            // Badges Grid
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 5,
                crossAxisSpacing: 8,
                mainAxisSpacing: 4,
                children: const [
                  SummaryChip(
                    icon: 'assets/images/ic_tik.svg',
                    text: "Great painting",
                  ),
                  SummaryChip(
                    icon: 'assets/images/ic_tik.svg',
                    text: "Active & healthy",
                  ),
                  SummaryChip(
                    icon: 'assets/images/ic_warning.svg',
                    text: "Had a small snack",
                  ),
                  SummaryChip(
                    icon: 'assets/images/ic_tik.svg',
                    text: "Used potty well",
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
      ],
    );
  }
}

class SummaryChip extends StatelessWidget {
  final String icon;
  final String text;

  const SummaryChip({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SvgPicture.asset(icon),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            color: Palette.textSecondaryForeground,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
