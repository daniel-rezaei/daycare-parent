import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:parent_app/resorces/style.dart';
import '../../../../resorces/pallete.dart';
import '../../data/model/biling_item_model.dart';
import '../bloc/billing_bloc.dart';
import '../bloc/billing_state.dart';
import '../../domain/entities/billing_entity.dart';

class BillingCard extends StatelessWidget {
  const BillingCard({super.key});

  List<BillingItemModel> buildBillingItems(List<BillingEntity> billings) {
    List<BillingItemModel> items = [];
    final today = DateTime.now();
    final formatter = NumberFormat.currency(
      locale: 'en_US',
      symbol: '\$',
      decimalDigits: 2,
    );

    final pastDue = billings.where((b) {
      final balance = double.tryParse(b.balanceMinor ?? "0") ?? 0;
      return (b.status == 'open' || b.status == 'partial') &&
          balance > 0 &&
          b.dueDate != null &&
          b.dueDate!.isBefore(today);
    }).toList();

    final upcoming = billings.where((b) {
      final balance = double.tryParse(b.balanceMinor ?? "0") ?? 0;
      return (b.status == 'open' || b.status == 'partial') &&
          balance > 0 &&
          (b.dueDate == null || !b.dueDate!.isBefore(today));
    }).toList();

    // تابع کمکی برای ساخت آیتم با عدد فرمت‌شده
    BillingItemModel mapToItem(BillingEntity b) {
      final balance = double.tryParse(b.balanceMinor ?? "0") ?? 0;
      final formattedBalance = formatter.format(balance / 100);

      return BillingItemModel.fromEntity(b).copyWith(
        trailing: formattedBalance,
      );
    }

    if (pastDue.isNotEmpty && upcoming.isNotEmpty) {
      items.addAll(pastDue.map(mapToItem));
      items.addAll(upcoming.map(mapToItem));
    } else if (pastDue.isNotEmpty) {
      items.addAll(pastDue.map(mapToItem));
      items.add(BillingItemModel.fromEntity(BillingEntity(status: 'paid')));
    } else if (upcoming.isNotEmpty) {
      items.addAll(upcoming.map(mapToItem));
      items.add(BillingItemModel.fromEntity(BillingEntity(status: 'paid')));
    } else {
      items.add(BillingItemModel.fromEntity(BillingEntity(status: 'paid')));
    }

    return items;
  }




  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BillingBloc, BillingState>(
      builder: (context, state) {
        if (state is BillingLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is BillingLoaded) {
          final items = buildBillingItems(state.billings);
          if (items.isEmpty) return const SizedBox.shrink();

          return Column(
            children: items.map((item) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 6),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: item.background,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(item.icon),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item.title,
                            style: AppTypography.textTheme.bodyLarge?.copyWith(
                              color: item.titleColor,
                              fontWeight: item.boldTitle ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                          const SizedBox(height: 4),
                          if (item.isRichSubtitle)
                            RichText(
                              text: TextSpan(
                                children: _buildDueTextSpans(item.subtitle),
                              ),
                            )
                          else
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                              child: Text(
                                item.subtitle,
                                style: const TextStyle(fontSize: 12, color: Colors.black54),
                              ),
                            ),
                          if (item.trailing != null)
                            Text(
                              item.trailing!,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        }

        if (state is BillingError) {
          return Center(child: Text("Error: ${state.message}"));
        }

        return const SizedBox.shrink();
      },
    );
  }

// متد کمکی برای رنگی کردن "Due"
  List<TextSpan> _buildDueTextSpans(String subtitle) {
    final spans = <TextSpan>[];
    final regex = RegExp(r'Due');
    int start = 0;

    for (final match in regex.allMatches(subtitle)) {
      // متن قبل از "Due"
      if (match.start > start) {
        spans.add(TextSpan(
          text: subtitle.substring(start, match.start),
          style: const TextStyle(
            fontSize: 12,
            color: Palette.txtInfo,
          ),
        ));
      }

      // خود "Due"
      spans.add(const TextSpan(
        text: 'Due',
        style: TextStyle(
          fontSize: 12,
          color: Palette.textMutedForeground,
          fontWeight: FontWeight.w400,
        ),
      ));

      start = match.end;
    }

    // متن بعد از آخرین "Due"
    if (start < subtitle.length) {
      spans.add(TextSpan(
        text: subtitle.substring(start),
        style: const TextStyle(
          fontSize: 12,
          color: Palette.txtInfo,
        ),
      ));
    }

    return spans;
  }

}
