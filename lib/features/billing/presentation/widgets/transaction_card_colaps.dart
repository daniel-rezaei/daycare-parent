import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../../resorces/pallete.dart';

class TransactionCardCollapse extends StatefulWidget {
  final String date;
  final String status;
  final Color statusColor;
  final String subtitle;
  final String type;
  final String description;
  final String amount;
  final Color amountColor;
  final String balance;

  const TransactionCardCollapse({
    super.key,
    required this.date,
    required this.status,
    required this.statusColor,
    required this.type,
    required this.description,
    required this.amount,
    required this.subtitle,
    required this.amountColor,
    required this.balance,
  });

  @override
  State<TransactionCardCollapse> createState() => _TransactionCardCollapseState();
}

class _TransactionCardCollapseState extends State<TransactionCardCollapse> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.currency(
      locale: 'en_US',
      symbol: '\$',
      decimalDigits: 2,
    );

// parse safely:
    double? _parse(String s) => double.tryParse(s.replaceAll(RegExp(r'[^\d.-]'), ''));

    final formattedStatus = widget.status.contains("\$") ? widget.status : "\$${widget.status}";
   // final formattedAmount = formatter.format((_parse(widget.amount) ?? 0) / 100);
  //  final formattedBalance = formatter.format((_parse(widget.balance) ?? 0) / 100);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6F6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Header (Clickable)
          GestureDetector(
            onTap: () => setState(() => _expanded = !_expanded),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: Palette.bgBackground80,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.date,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 8,),
                      Text(widget.subtitle,
                          style: const TextStyle(fontWeight: FontWeight.w400,
                          fontSize: 14,color: Palette.textMutedForeground)),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: widget.statusColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Row(
                          children: [
                            // ✅ شرط برای نمایش SVG
                            widget.statusColor == Colors.green
                                ? SvgPicture.asset(
                              "assets/images/ic_full_amount.svg",
                              height: 16,
                            )
                                : SvgPicture.asset(
                              "assets/images/ic_deposit.svg",
                              height: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              formattedStatus,
                              style: TextStyle(
                                color: widget.statusColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),

                      // Arrow Icon
                      AnimatedRotation(
                        turns: _expanded ? 0.5 : 0,
                        duration: const Duration(milliseconds: 250),
                        child: const Icon(Icons.keyboard_arrow_down),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),

          // Expandable Content
          if (_expanded)
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Palette.bgBackground90,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Column(
                  children: [
                    rowLabel("Invoice",
                        InkWell(
                          borderRadius: BorderRadius.circular(6),
                          onTap: () {
                            // your action
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: Colors.grey.shade300, // رنگ کادر خیلی کم
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset('assets/images/ic_pdf.svg', height: 18),
                                const SizedBox(width: 6),
                                const Text(
                                  "Download PDF",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Palette.textSecondaryForeground,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )

                    ),
                    label("Type", widget.type),
                    label("Description", widget.description),
                    badge("Amount", widget.amount.contains("\$") ? widget.amount : "\$${widget.amount}", widget.amountColor),
                    badge("Balance", widget.balance.contains("\$") ? widget.balance : "\$${widget.balance}", Colors.grey[800]!),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget rowLabel(String text, Widget action) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: const TextStyle(color: Colors.grey)),
          action,
        ],
      ),
    );
  }

  Widget label(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          const SizedBox(height: 4),
          Text(value,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
        ],
      ),
    );
  }

  Widget badge(String title, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFEDEDED),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                if (color == Colors.green)
                  SvgPicture.asset('assets/images/ic_amount_billing.svg', height: 16)
                else
                  SvgPicture.asset('assets/images/ic_amount_billing.svg', height: 16,
                    color: title == "Amount" ? Colors.red : Colors.grey.shade600,),
                SizedBox(width: 4,),
                Text(value,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: color)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
