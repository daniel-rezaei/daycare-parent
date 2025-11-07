
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/billing_summery_bloc.dart';
import '../bloc/billing_summery_state.dart';
import '../widgets/balance_card.dart';
import '../widgets/payment_history_list.dart';

class BillingPage extends StatefulWidget {
  const BillingPage({super.key});

  @override
  State<BillingPage> createState() => _BillingPageState();
}

class _BillingPageState extends State<BillingPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE9DFFF), Color(0xFFF3EFFF)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text(
              'Billing',
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: BlocBuilder<BillingSummeryBloc, BillingSummeryState>(
            builder: (context, state) {
              if (state is BillingSummeryLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is BillingSummeryError) {
                return Center(child: Text("Error: ${state.message}"));
              }

              if (state is BillingSummeryLoaded) {
                return Column(
                  children: [
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: BalanceCard(
                        currentBalance: state.summary.currentBalanceMinor,
                        pending: state.summary.pendingMinor,
                        currency: state.summary.currencyIso,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Expanded(child: PaymentsHistoryList())
                  ],
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }
}






