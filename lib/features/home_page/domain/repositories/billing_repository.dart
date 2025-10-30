
import '../entities/billing_entity.dart';

abstract class BillingRepository {
  Future<List<BillingEntity>> getBillings();
}
