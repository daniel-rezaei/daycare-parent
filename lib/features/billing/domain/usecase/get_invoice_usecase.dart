


import '../entity/invoice_entity.dart';
import '../repository/biling_card_repository.dart';

class GetInvoicesUseCase {
  final BillingCardRepository repository;

  GetInvoicesUseCase(this.repository);

  Future<List<InvoiceEntity>> call() async {
    return await repository.getInvoices();
  }
}
