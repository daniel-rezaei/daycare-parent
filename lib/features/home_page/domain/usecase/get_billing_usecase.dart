
import '../entities/billing_entity.dart';
import '../repositories/billing_repository.dart';

class GetBillingUseCase {
  final BillingRepository repository;

  GetBillingUseCase(this.repository);

  Future<List<BillingEntity>> call() async {
    return await repository.getBillings();
  }
}
