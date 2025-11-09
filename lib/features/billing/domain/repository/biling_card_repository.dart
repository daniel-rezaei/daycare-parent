


import '../entity/invoice_entity.dart';
import '../entity/payment_entity.dart';

abstract class BillingCardRepository {
  Future<List<InvoiceEntity>> getInvoices();
  Future<List<PaymentEntity>> getPayments();
}
