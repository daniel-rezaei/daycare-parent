
import 'dart:convert';
import 'package:parent_app/core/network/dio_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entity/billing_summery_entity.dart';
import '../../domain/repository/billing_summery_repository.dart';
import '../model/billing_summery_model.dart';



class BillingSummeryRepositoryImpl extends BillingSummeryRepository {
  final DioClient dio;

  BillingSummeryRepositoryImpl(this.dio);

  @override
  Future<BillingSummaryEntity> getParentBillingSummary({String? childId}) async {
    try {
      if (childId == null) {
        throw Exception("Child ID is required");
      }

      // 1️⃣ گرفتن guardianId
      final guardianId = await _getLoggedInGuardianId();

      print('📡 Guardian ID fetched: $guardianId');
      print('📡 Child ID passed to repository: $childId');

      // 2️⃣ گرفتن همه invoice های مربوط به child_id
      final invRes = await dio.get(
        '/items/Invoice',
        queryParameters: {
          "filter[child_id][_eq]": childId,
          "filter[status][_in]": ["open", "partial", "past due"],
        },
      );

      final invoices = invRes.data["data"] as List;
      String currentBalance = "0";
      String currency = "USD";

      if (invoices.isNotEmpty) {
        // مجموع balance ها یا آخرین balance؟
        currentBalance = invoices.last["balance_minor"].toString();
        currency = invoices.last["currency_iso"] ?? currency;
      }

      print('📦 Invoices fetched: ${invoices.length}');

      // 3️⃣ گرفتن billing account مربوط به guardian
      final baRes = await dio.get(
        '/items/billing_account_guardian',
        queryParameters: {"filter[guardian_id][_eq]": guardianId},
      );

      final baData = baRes.data["data"];
      if (baData.isEmpty) {
        throw Exception("No billing accounts found for guardian");
      }

      final billingAccountId = baData[0]["billing_account_id"][0];
      print('💳 Billing Account ID: $billingAccountId');

      // 4️⃣ Pending Payments
      final payRes = await dio.get(
        '/items/Payment',
        queryParameters: {
          "filter[billing_account_id][_eq]": billingAccountId,
          "filter[status][_eq]": "pending",
        },
      );

      final payments = payRes.data["data"] as List;
      List<String> pendingAmounts = payments.map((p) => p["amount_minor"].toString()).toList();
      print('💰 Pending payments: ${pendingAmounts.join(", ")}');

      // 5️⃣ Pending Charges
      final pcRes = await dio.get(
        '/items/Pending_Charges',
        queryParameters: {
          "filter[billing_account_id][_eq]": billingAccountId,
          "filter[status][_in]": ["pending", "scheduled"],
        },
      );

      final charges = pcRes.data["data"] as List;
      pendingAmounts.addAll(charges.map((c) => c["amount_minor"].toString()));
      print('! Pending charges: ${charges.map((c) => c["amount_minor"].toString()).join(", ")}');

      final pending = pendingAmounts.isNotEmpty ? pendingAmounts.join(", ") : "0";

      return BillingSummaryModel(
        currentBalanceMinor: currentBalance,
        pendingMinor: pending,
        currencyIso: currency,
        guardianId: guardianId,
      );
    } catch (e) {
      throw Exception("Billing summary fetch failed: $e");
    }
  }

  /// گرفتن guardianId از SharedPreferences و API
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
      return guardianId;
    } catch (e) {
      rethrow;
    }
  }
}


