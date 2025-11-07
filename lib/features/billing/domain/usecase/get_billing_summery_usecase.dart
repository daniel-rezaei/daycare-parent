



import '../entity/billing_summery_entity.dart';
import '../repository/billing_summery_repository.dart';

class GetBillingSummaryUseCase {
  final BillingSummeryRepository repository;

  GetBillingSummaryUseCase(this.repository);

  Future<BillingSummaryEntity> call() async {
    return repository.getParentBillingSummary();
  }
}
