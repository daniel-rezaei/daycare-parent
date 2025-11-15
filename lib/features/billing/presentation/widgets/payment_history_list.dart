//
// import 'package:flutter/material.dart';
// import 'package:parent_app/features/billing/presentation/screen/transaction_card_colaps.dart';
//
// class PaymentsHistoryList extends StatelessWidget {
//   const PaymentsHistoryList({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.6,
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(24),
//           topRight: Radius.circular(24),
//         ),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(left: 8.0, top: 8.0),
//               child: Text(
//                 'Payments History',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w700,
//                   color: Colors.grey[800],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 12),
//
//             // ✅ این Scroll برای لیست تراکنش هاست
//             Expanded(
//               child: ListView(
//                 children: const [
//                   TransactionCardCollapse(
//                     date: "Jul 1, 2025",
//                     subtitle: "Direction Deposit",
//                     status: "\$1000",
//                     statusColor: Colors.red,
//                     type: "Direction Deposit",
//                     description: "Direction Deposit",
//                     amount: "\$1450.50",
//                     amountColor: Colors.green,
//                     balance: "\$1450.50",
//                   ),
//                   SizedBox(height: 12),
//                   TransactionCardCollapse(
//                     date: "Jul 27, 2025",
//                     subtitle: "Full Amount",
//                     status: "\$1000",
//                     statusColor: Colors.green,
//                     type: "Direction Deposit",
//                     description: "Direction Deposit",
//                     amount: "\$1450.50",
//                     amountColor: Colors.green,
//                     balance: "\$1450.50",
//                   ),
//                   TransactionCardCollapse(
//                     date: "Jul 27, 2025",
//                     subtitle: "Full Amount",
//                     status: "\$1000",
//                     statusColor: Colors.green,
//                     type: "Direction Deposit",
//                     description: "Direction Deposit",
//                     amount: "\$1450.50",
//                     amountColor: Colors.green,
//                     balance: "\$1450.50",
//                   ),
//                   SizedBox(height: 12),
//                   TransactionCardCollapse(
//                     date: "Jul 27, 2025",
//                     subtitle: "Full Amount",
//                     status: "\$1000",
//                     statusColor: Colors.green,
//                     type: "Direction Deposit",
//                     description: "Direction Deposit",
//                     amount: "\$1450.50",
//                     amountColor: Colors.green,
//                     balance: "\$1450.50",
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:parent_app/features/billing/presentation/bloc/billing_card_bloc.dart';
import 'package:parent_app/features/billing/presentation/bloc/billing_card_state.dart';
import 'package:parent_app/features/billing/presentation/widgets/transaction_card_colaps.dart';


class PaymentsHistoryList extends StatelessWidget {
  const PaymentsHistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BillingCardBloc, BillingCardState>(
      builder: (context, state) {
        if (state is BillingCardLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is BillingCardError) {
          return Center(child: Text("Error: ${state.message}"));
        }

        if (state is BillingCardLoaded) {
          final cards = <Widget>[];
          final dateFormat = DateFormat("MMM d, yyyy");

          // 🔴 Invoice ها
          for (var invoice in state.invoices) {
            cards.add(TransactionCardCollapse(
              date: dateFormat.format(invoice.issueDate),
              subtitle: invoice.invoiceNumber,
              status: "\$${invoice.totalMinor}",
              statusColor: Colors.red,
              type: invoice.status,
              description: invoice.meta ?? "",
              amount: "\$${invoice.totalMinor}",
              amountColor: Colors.red,
              balance: "\$${invoice.balanceMinor}",
            ));
            cards.add(const SizedBox(height: 12));
          }

          // 🟢 Payment ها
          for (var payment in state.payments) {
            cards.add(TransactionCardCollapse(
              date: dateFormat.format(payment.paymentDate),
              subtitle: payment.paymentMethod ?? payment.provider ?? "Payment",
              status: "\$${payment.amountMinor}",
              statusColor: Colors.green,
              type: payment.status,
              description: payment.meta ?? payment.provider ?? "",
              amount: "\$${payment.amountMinor}",
              amountColor: Colors.green,
              balance: "",
            ));
            cards.add(const SizedBox(height: 12));
          }

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
                  Expanded(
                    child: ListView(
                      children: cards,
                    ),
                  ),
                ],
              ),
            ),
          );
        }


        return const SizedBox.shrink();
      },
    );
  }
}
