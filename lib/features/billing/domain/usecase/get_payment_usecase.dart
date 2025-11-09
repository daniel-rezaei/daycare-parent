

import '../entity/payment_entity.dart';
import '../repository/biling_card_repository.dart';

class GetPaymentsUseCase {
  final BillingCardRepository repository;

  GetPaymentsUseCase(this.repository);

  Future<List<PaymentEntity>> call() async {
    return await repository.getPayments();
  }
}
