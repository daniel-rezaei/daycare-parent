
import 'package:flutter/material.dart';
import 'package:parent_app/features/billing/presentation/widgets/transaction_card_colaps.dart';

class PaymentsHistoryList extends StatelessWidget {
  const PaymentsHistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8.0),
              child: Text(
                'Payments History',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey[800],
                ),
              ),
            ),
            const SizedBox(height: 12),

            // ✅ این Scroll برای لیست تراکنش هاست
            Expanded(
              child: ListView(
                children: const [
                  TransactionCardCollapse(
                    date: "Jul 1, 2025",
                    subtitle: "Direction Deposit",
                    status: "\$1000",
                    statusColor: Colors.red,
                    type: "Direction Deposit",
                    description: "Direction Deposit",
                    amount: "\$1450.50",
                    amountColor: Colors.green,
                    balance: "\$1450.50",
                  ),
                  SizedBox(height: 12),
                  TransactionCardCollapse(
                    date: "Jul 27, 2025",
                    subtitle: "Full Amount",
                    status: "\$1000",
                    statusColor: Colors.green,
                    type: "Direction Deposit",
                    description: "Direction Deposit",
                    amount: "\$1450.50",
                    amountColor: Colors.green,
                    balance: "\$1450.50",
                  ),
                  TransactionCardCollapse(
                    date: "Jul 27, 2025",
                    subtitle: "Full Amount",
                    status: "\$1000",
                    statusColor: Colors.green,
                    type: "Direction Deposit",
                    description: "Direction Deposit",
                    amount: "\$1450.50",
                    amountColor: Colors.green,
                    balance: "\$1450.50",
                  ),
                  SizedBox(height: 12),
                  TransactionCardCollapse(
                    date: "Jul 27, 2025",
                    subtitle: "Full Amount",
                    status: "\$1000",
                    statusColor: Colors.green,
                    type: "Direction Deposit",
                    description: "Direction Deposit",
                    amount: "\$1450.50",
                    amountColor: Colors.green,
                    balance: "\$1450.50",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

  }
}