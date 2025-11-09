import 'package:flutter/material.dart';
import '../../../../resorces/pallete.dart';
import '../../domain/entities/billing_entity.dart';

class BillingItemModel {
  final String icon;
  final String title;
  final Color titleColor;
  final String subtitle;
  final String? trailing;
  final Color background;
  final bool boldTitle;
  final bool isRichSubtitle;

  BillingItemModel({
    required this.icon,
    required this.title,
    required this.titleColor,
    required this.subtitle,
    this.trailing,
    required this.background,
    this.boldTitle = false,
    this.isRichSubtitle = false,
  });

  /// ساخت کارت UI از BillingEntity برای Paid / Amount Due / Past Due
  factory BillingItemModel.fromEntity(BillingEntity entity) {
    final now = DateTime.now();
    final balance = double.tryParse(entity.balanceMinor ?? "0") ?? 0;

    // Paid / Nice work
    if (entity.status == 'paid') {
      return BillingItemModel(
        icon: 'assets/images/ic_check_green.svg',
        title: "Nice work!",
        titleColor: Palette.textSuccess,
        subtitle: "Your account is looking healthy.",
        background: Palette.bgBackgroundSu10,
        boldTitle: true,
      );
    }

    // Past Due
    if ((entity.status == 'open' || entity.status == 'partial') &&
        balance > 0 &&
        entity.dueDate != null &&
        entity.dueDate!.isBefore(now)) {
      return BillingItemModel(
        icon: 'assets/images/ic_past_due.svg',
        title: "Amount Past Due",
        titleColor: Colors.redAccent,
        subtitle: "Overdue by ${now.difference(entity.dueDate!).inDays} days",
        trailing: "\$$balance",
        background: Colors.red.shade50,
        boldTitle: true,
        isRichSubtitle: true,
      );
    }

    // Amount Due (upcoming)
    if ((entity.status == 'open' || entity.status == 'partial') &&
        balance > 0) {
      return BillingItemModel(
        icon: 'assets/images/ic_amount.svg',
        title: "Amount Due",
        titleColor: Palette.textSecondaryForeground,
        subtitle: entity.dueDate != null
            ? "Due ${entity.formattedDueDate}"
            : "No due date",
        trailing: "\$$balance",
        background: Colors.white,
        boldTitle: true,
        isRichSubtitle: entity.dueDate != null,
      );
    }

    // پیش‌فرض
    return BillingItemModel(
      icon: 'assets/images/ic_info.svg',
      title: "Unknown",
      titleColor: Colors.grey,
      subtitle: "",
      background: Colors.white,
    );
  }
  BillingItemModel copyWith({
    String? title,
    String? subtitle,
    String? icon,
    String? trailing,
    Color? background,
    Color? titleColor,
    bool? boldTitle,
    bool? isRichSubtitle,
  }) {
    return BillingItemModel(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      icon: icon ?? this.icon,
      trailing: trailing ?? this.trailing,
      background: background ?? this.background,
      titleColor: titleColor ?? this.titleColor,
      boldTitle: boldTitle ?? this.boldTitle,
      isRichSubtitle: isRichSubtitle ?? this.isRichSubtitle,
    );
  }

}
