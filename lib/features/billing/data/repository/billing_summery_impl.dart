import 'package:dio/dio.dart';
import 'package:parent_app/core/network/dio_client.dart';

import '../../domain/entity/billing_summery_entity.dart';
import '../../domain/repository/billing_summery_repository.dart';
import '../model/billing_summery_model.dart';

class BillingSummeryRepositoryImpl extends BillingSummeryRepository {
  final DioClient dio;

  BillingSummeryRepositoryImpl(this.dio);

  @override
  Future<BillingSummaryEntity> getParentBillingSummary() async {
    try {
      final guardianId = await _getLoggedInGuardianId(); // TODO: replace with your real auth method

      // 1️⃣ Get billing account
      final baRes = await dio.get(
        '/items/billing_account_guardian',
        queryParameters: {
          "filter[guardian_id][_eq]": guardianId,
        },
      );

      final baData = baRes.data["data"];
      if (baData.isEmpty) {
        throw Exception("No billing accounts found");
      }

      final billingAccountId = baData[0]["billing_account_id"][0];

      // 2️⃣ Get invoices
      final invRes = await dio.get(
        '/items/Invoice',
        queryParameters: {
          "filter[billing_account_id][_eq]": billingAccountId,
          "filter[status][_in]": "open,partial,past due",
        },
      );

      final invoices = invRes.data["data"] as List;
      int currentBalance = 0;
      String currency = "USD";

      for (var inv in invoices) {
        currentBalance += double.parse(inv["balance_minor"].toString()).round();
        currency = inv["currency_iso"] ?? currency;
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
      int pendingPayments = 0;
      for (var p in payments) {
        pendingPayments += double.parse(p["amount_minor"].toString()).round();
      }

      // 4️⃣ Pending Charges
      final pcRes = await dio.get(
        '/items/Pending_Charges',
        queryParameters: {
          "filter[billing_account_id][_eq]": billingAccountId,
          "filter[status][_in]": "pending,scheduled",
        },
      );

      final charges = pcRes.data["data"] as List;
      int pendingCharges = 0;
      for (var c in charges) {
        pendingCharges += double.parse(c["amount_minor"].toString()).round();
      }

      final totalPending = pendingPayments + pendingCharges;

      return BillingSummaryModel(
        currentBalanceMinor: currentBalance,
        pendingMinor: totalPending,
        currencyIso: currency,
      );
    } catch (e) {
      throw Exception("Billing summary fetch failed: $e");
    }
  }

  /// TODO: replace with real token/secure storage user lookup
  Future<String> _getLoggedInGuardianId() async {
    return "93710041-b937-4482-b085-b41672e93070"; // hardcoded for now
  }
}
