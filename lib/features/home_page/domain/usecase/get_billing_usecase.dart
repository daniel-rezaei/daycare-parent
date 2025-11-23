
import '../entities/billing_entity.dart';
import '../repositories/billing_repository.dart';

class GetBillingUseCase {
  final BillingRepository repository;

  GetBillingUseCase(this.repository);

  Future<List<BillingEntity>> call({required String childId})async{
    return await repository.getBillings(childId);
  }
}
