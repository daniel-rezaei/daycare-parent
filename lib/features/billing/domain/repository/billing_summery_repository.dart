


import '../entity/billing_summery_entity.dart';

abstract class BillingSummeryRepository {
  Future<BillingSummaryEntity> getParentBillingSummary();
}
