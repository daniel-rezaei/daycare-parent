import 'package:parent_app/core/network/dio_client.dart';
import '../../domain/entity/invoice_entity.dart';
import '../../domain/entity/payment_entity.dart';
import '../../domain/repository/biling_card_repository.dart';
import '../model/invoice_model.dart';
import '../model/payment_model.dart';


class BillingCardRepositoryImpl implements BillingCardRepository {
  final DioClient dioClient;

  BillingCardRepositoryImpl(this.dioClient);

  @override
  Future<List<InvoiceEntity>> getInvoices() async {
    try {
      final response = await dioClient.get('/items/Invoice');
      final data = (response.data['data'] as List)
          .map((json) => InvoiceModel.fromJson(json)) // ✅ از مدل امن استفاده کنید
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
          .map((json) => PaymentModel.fromJson(json)) // ✅ از مدل امن استفاده کنید
          .toList();
      return data;
    } catch (e) {
      rethrow;
    }
  }
}

