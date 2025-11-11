
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:parent_app/features/billing/presentation/widgets/show_statement_bottom_sheet.dart';
import 'package:parent_app/features/billing/presentation/widgets/show_tax_statement_bottom_sheet.dart';

import '../../../../resorces/pallete.dart';

class BalanceCard extends StatelessWidget {
  final String currentBalance;
  final String pending;
  final String currency;
  final String guardianId;

  BalanceCard({
    super.key,
    required this.currentBalance,
    required this.pending,
    required this.currency,
    required this.guardianId,
  });

  final NumberFormat moneyFormat = NumberFormat.currency(
    locale: 'en_US',
    symbol: '\$',
    decimalDigits: 2,
  );


  @override
  Widget build(BuildContext context) {
  //  final balanceFormatted = moneyFormat.format(currentBalance / 100);
   // final pendingFormatted = moneyFormat.format(pending / 100);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Palette.bgColorBilling, Palette.borderPrimary0],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.purpleAccent.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          )
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'current balance',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\$$currentBalance",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[900],
                          ),
                        ),

                        // ✅ Pending Pill — حتی اگه صفر باشه باید نمایش داده بشه
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: Palette.borderPrimary20,
                            border: Border.all(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset('assets/images/ic_pending.svg'),
                              const SizedBox(width: 6),
                              Text(
                                "Pending \$$pending",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Palette.textMutedForeground,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Pay Now button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Palette.txtTagForeground3,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 6,
                shadowColor: Colors.purpleAccent.withOpacity(0.2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  Text('Pay Now', style: TextStyle(fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white)),
                  SizedBox(width: 8),
                  SvgPicture.asset('assets/images/ic_arrow_right_billing.svg'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Statement & Tax Statement buttons
          Row(
            children: [
              Expanded(
                child: TextButton.icon(
                  onPressed: () =>showStatementBottomSheet(context,guardianId),
                  icon: SvgPicture.asset('assets/images/ic_statement.svg'),
                  label: const Text('Statement',style: TextStyle(
                      fontSize: 14,fontWeight: FontWeight.w500,
                      color: Palette.textForeground
                  ),),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

              ),
              const SizedBox(width: 10),
              Expanded(
                child:  TextButton.icon(
                  onPressed: () =>showTaxStatementBottomSheet(context,guardianId),
                  icon: SvgPicture.asset('assets/images/ic_bill_tax.svg'),
                  label: const Text('Tax Statement',style: TextStyle(
                      fontSize: 14,fontWeight: FontWeight.w500,
                      color: Palette.textForeground
                  ),),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}