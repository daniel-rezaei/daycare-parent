
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../resorces/pallete.dart';

void showStatementBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                   SvgPicture.asset('assets/images/ic_statement.svg'),
                    const SizedBox(width: 6),
                    Text(
                      "Billing Statement",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[800],
                      ),
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: SvgPicture.asset('assets/images/ic_cancel.svg'),
                )
              ],
            ),

            const SizedBox(height: 20),
          Divider(height: 1,color: Palette.bgBorder,),
            /// PDF Icon
            Container(
              padding: const EdgeInsets.all(20),
              child: SvgPicture.asset('assets/images/ic_pdf_large.svg'),
            ),

            const SizedBox(height: 18),

            /// Title
            const Text(
              "Download PDF File",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Palette.textForeground,
              ),
            ),

            const SizedBox(height: 6),

            /// Subtitle
            Text(
              "Download or view your latest statement",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Palette.textForeground,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 24),

            /// Download Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // عمل دانلود PDF
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Palette.txtTagForeground3,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Download",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,
                  color: Palette.textPrimaryForeground),
                ),
              ),
            ),

            const SizedBox(height: 12),

            /// Cancel Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: BorderSide(color: Colors.grey.shade300),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                    fontSize: 16,
                    color: Palette.textSecondaryForeground,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 18),
          ],
        ),
      );
    },
  );
}
