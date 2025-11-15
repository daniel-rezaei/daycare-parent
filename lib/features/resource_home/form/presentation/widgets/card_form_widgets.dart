import 'package:flutter/material.dart';
import 'package:parent_app/resorces/pallete.dart';

class CardFormWidgets extends StatelessWidget {
  final String title;
  final String subtitle;
  final String status;
  const CardFormWidgets({super.key, required this.title, required this.subtitle,
  required this.status});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Palette.backgroundBgPink,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // ⚡ Expanded اضافه شد تا Row overflow نده
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Palette.textForeground,
                      ),
                      overflow: TextOverflow.ellipsis, // کوتاه کردن متن بلند
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Palette.textMutedForeground,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            // وضعیت assignment
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  border: Border.all(color: Palette.bgBorder, width: 1),
                ),
                child:  Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                   status,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Palette.textForeground,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
