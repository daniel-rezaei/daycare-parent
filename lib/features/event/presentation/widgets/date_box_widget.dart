
import 'package:flutter/material.dart';

class DateBox extends StatelessWidget {
  final String month;
  final String day;
  final Color color;
  final Color bgColor;

  const DateBox({super.key, required this.month, required this.day,
    required this.color,required this.bgColor});

  @override
  Widget build(BuildContext context) {
    final circleColor = HSLColor.fromColor(color)
        .withLightness((HSLColor.fromColor(color).lightness - 0.2).clamp(0.0, 1.0))
        .toColor();
    return Container(
      width: 64,
      height: 110,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: circleColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(height: 8),
          Text(month, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          Text(day, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
