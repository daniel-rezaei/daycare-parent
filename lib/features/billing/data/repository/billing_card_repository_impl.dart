import 'package:parent_app/core/network/dio_client.dart';
import '../../domain/entity/invoice_entity.dart';
import '../../domain/entity/payment_entity.dart';
import '../../domain/repository/biling_card_repository.dart';


class BillingCardRepositoryImpl implements BillingCardRepository {
  final DioClient dioClient;

  BillingCardRepositoryImpl(this.dioClient);

  @override
  Future<List<InvoiceEntity>> getInvoices() async {
    try {
      final response = await dioClient.get('/items/Invoice');
      final data = (response.data['data'] as List)
          .map((json) => InvoiceEntity(
        id: json['id'],
        billingAccountId: json['billing_account_id'],
        meta: json['meta'],
        currencyIso: json['currency_iso'],
        invoiceNumber: json['invoice_number'],
        status: json['status'],
        dueDate: DateTime.parse(json['due_date']),
        issueDate: DateTime.parse(json['issue_date']),
        balanceMinor: double.parse(json['balance_minor']),
        totalMinor: double.parse(json['total_minor']),
        pdfDocumentId: json['pdf_document_id'],
      ))
          .toList();
      return data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<PaymentEntity>> getPayments() async {
    try {
      final response = await dioClient.get('/items/Payment');
      final data = (response.data['data'] as List)
          .map((json) => PaymentEntity(
        id: json['id'],
        billingAccountId: json['billing_account_id'],
        meta: json['meta'],
        paymentMethod: json['Payment_Method'],
        currencyIso: json['currency_iso'],
        provider: json['provider'],
        status: json['status'],
        paymentDate: DateTime.parse(json['Payment_Date']),
        amountMinor: double.parse(json['amount_minor']),
        invoiceIds: (json['invoice_id'] as List?)
            ?.map((e) => e.toString())
            .toList(),
      ))
          .toList();
      return data;
    } catch (e) {
      rethrow;
    }
  }
}
