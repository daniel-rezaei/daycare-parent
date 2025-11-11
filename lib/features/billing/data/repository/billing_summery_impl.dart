// import 'dart:convert';
//
// import 'package:dio/dio.dart';
// import 'package:parent_app/core/network/dio_client.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../domain/entity/billing_summery_entity.dart';
// import '../../domain/repository/billing_summery_repository.dart';
// import '../model/billing_summery_model.dart';
//
// class BillingSummeryRepositoryImpl extends BillingSummeryRepository {
//   final DioClient dio;
//
//   BillingSummeryRepositoryImpl(this.dio);
//
//   @override
//   Future<BillingSummaryEntity> getParentBillingSummary() async {
//     try {
//       final guardianId = await _getLoggedInGuardianId(); // TODO: replace with your real auth method
//
//       // 1️⃣ Get billing account
//       final baRes = await dio.get(
//         '/items/billing_account_guardian',
//         queryParameters: {
//           "filter[guardian_id][_eq]": guardianId,
//         },
//       );
//
//       final baData = baRes.data["data"];
//       if (baData.isEmpty) {
//         throw Exception("No billing accounts found");
//       }
//
//       final billingAccountId = baData[0]["billing_account_id"][0];
//
//       // 2️⃣ Get invoices
//       final invRes = await dio.get(
//         '/items/Invoice',
//         queryParameters: {
//           "filter[billing_account_id][_eq]": billingAccountId,
//           "filter[status][_in]": "open,partial,past due",
//         },
//       );
//
//       final invoices = invRes.data["data"] as List;
//       int currentBalance = 0;
//       String currency = "USD";
//
//       for (var inv in invoices) {
//         currentBalance += double.parse(inv["balance_minor"].toString()).round();
//         currency = inv["currency_iso"] ?? currency;
//       }
//
//       // 3️⃣ Pending Payments
//       final payRes = await dio.get(
//         '/items/Payment',
//         queryParameters: {
//           "filter[billing_account_id][_eq]": billingAccountId,
//           "filter[status][_eq]": "pending",
//         },
//       );
//
//       final payments = payRes.data["data"] as List;
//       int pendingPayments = 0;
//       for (var p in payments) {
//         pendingPayments += double.parse(p["amount_minor"].toString()).round();
//       }
//
//       // 4️⃣ Pending Charges
//       final pcRes = await dio.get(
//         '/items/Pending_Charges',
//         queryParameters: {
//           "filter[billing_account_id][_eq]": billingAccountId,
//           "filter[status][_in]": "pending,scheduled",
//         },
//       );
//
//       final charges = pcRes.data["data"] as List;
//       int pendingCharges = 0;
//       for (var c in charges) {
//         pendingCharges += double.parse(c["amount_minor"].toString()).round();
//       }
//
//       final totalPending = pendingPayments + pendingCharges;
//
//       return BillingSummaryModel(
//         currentBalanceMinor: currentBalance,
//         pendingMinor: totalPending,
//         currencyIso: currency,
//       );
//     } catch (e) {
//       throw Exception("Billing summary fetch failed: $e");
//     }
//   }
//
//   /// TODO: replace with real token/secure storage user lookup
//   Future<String> _getLoggedInGuardianId() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final userJson = prefs.getString('logged_in_user');
//
//       if (userJson == null) {
//         throw Exception('❌ No logged in user found in SharedPreferences');
//       }
//
//       final Map<String, dynamic> userMap = jsonDecode(userJson);
//       final contactId = userMap['contactId']?.toString();
//
//       if (contactId == null || contactId.isEmpty) {
//         throw Exception('❌ Contact ID not found in saved user');
//       }
//
//       print('📡 Fetching guardianId for contactId: $contactId');
//
//       // 🔹 فراخوانی API برای گرفتن Guardian بر اساس contact_id
//       final response = await dio.get(
//         '/items/Guardian',
//         queryParameters: {
//           'filter[contact_id][_eq]': contactId,
//           'fields': 'id, contact_id',
//         },
//       );
//
//       final data = response.data['data'] as List;
//
//       if (data.isEmpty) {
//         throw Exception('❌ No Guardian found for contact_id: $contactId');
//       }
//
//       final guardianId = data.first['id'].toString();
//
//       print('✅ Guardian ID fetched from API: $guardianId');
//       return guardianId;
//     } catch (e) {
//       print('🚨 Error fetching guardian ID: $e');
//       rethrow;
//     }
//   }
//
//
// }
//
//
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:parent_app/core/network/dio_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entity/billing_summery_entity.dart';
import '../../domain/repository/billing_summery_repository.dart';
import '../model/billing_summery_model.dart';

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:parent_app/core/network/dio_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entity/billing_summery_entity.dart';
import '../../domain/repository/billing_summery_repository.dart';
import '../model/billing_summery_model.dart';

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:parent_app/core/network/dio_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entity/billing_summery_entity.dart';
import '../../domain/repository/billing_summery_repository.dart';
import '../model/billing_summery_model.dart';

class BillingSummeryRepositoryImpl extends BillingSummeryRepository {
  final DioClient dio;

  BillingSummeryRepositoryImpl(this.dio);

  @override
  Future<BillingSummaryEntity> getParentBillingSummary() async {
    try {
      final guardianId = await _getLoggedInGuardianId();

      // 1️⃣ Get billing account
      final baRes = await dio.get(
        '/items/billing_account_guardian',
        queryParameters: {"filter[guardian_id][_eq]": guardianId},
      );

      final baData = baRes.data["data"];
      if (baData.isEmpty) {
        throw Exception("No billing accounts found for guardian");
      }

      final billingAccountId = baData[0]["billing_account_id"][0];

      // 2️⃣ Get invoices
      final invRes = await dio.get(
        '/items/Invoice',
        queryParameters: {
          "filter[billing_account_id][_eq]": billingAccountId,
          "filter[status][_in]": ["open", "partial", "past due"],
        },
      );

      final invoices = invRes.data["data"] as List;
      String currentBalance = "0";
      String currency = "USD";

      if (invoices.isNotEmpty) {
        // دقیقاً همان مقداری که سرور داده
        currentBalance = invoices.last["balance_minor"].toString();
        currency = invoices.last["currency_iso"] ?? currency;
      }

      // 3️⃣ Pending Payments
      final payRes = await dio.get(
        '/items/Payment',
        queryParameters: {
          "filter[billing_account_id][_eq]": billingAccountId,
          "filter[status][_eq]": "pending",
        },
      );

      final payments = payRes.data["data"] as List;
      // همه مقادیر pending را مستقیم نگه می‌داریم به صورت رشته
      List<String> pendingAmounts = payments.map((p) => p["amount_minor"].toString()).toList();

      // 4️⃣ Pending Charges
      final pcRes = await dio.get(
        '/items/Pending_Charges',
        queryParameters: {
          "filter[billing_account_id][_eq]": billingAccountId,
          "filter[status][_in]": ["pending", "scheduled"],
        },
      );

      final charges = pcRes.data["data"] as List;
      pendingAmounts.addAll(charges.map((c) => c["amount_minor"].toString()));

      // اگر بخوای همه pending ها را یکجا نمایش بدی:
      final pending = pendingAmounts.isNotEmpty ? pendingAmounts.join(", ") : "0";

      return BillingSummaryModel(
        currentBalanceMinor: currentBalance, // رشته مستقیم سرور
        pendingMinor: pending,              // رشته مستقیم سرور
        currencyIso: currency,
        guardianId: guardianId,
      );
    } catch (e) {
      throw Exception("Billing summary fetch failed: $e");
    }
  }

  /// دریافت guardianId از SharedPreferences و API
  Future<String> _getLoggedInGuardianId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString('logged_in_user');

      if (userJson == null) {
        throw Exception('❌ No logged in user found in SharedPreferences');
      }

      final Map<String, dynamic> userMap = jsonDecode(userJson);
      final contactId = userMap['contactId']?.toString();

      if (contactId == null || contactId.isEmpty) {
        throw Exception('❌ Contact ID not found in saved user');
      }

      print('📡 Fetching guardianId for contactId: $contactId');

      final response = await dio.get(
        '/items/Guardian',
        queryParameters: {
          'filter[contact_id][_eq]': contactId,
          'fields': 'id,contact_id',
        },
      );

      final data = response.data['data'] as List;
      if (data.isEmpty) {
        throw Exception('❌ No Guardian found for contact_id: $contactId');
      }

      final guardianId = data.first['id'].toString();
      print('✅ Guardian ID fetched from API: $guardianId');
      return guardianId;
    } catch (e) {
      print('🚨 Error fetching guardian ID: $e');
      rethrow;
    }
  }
}


