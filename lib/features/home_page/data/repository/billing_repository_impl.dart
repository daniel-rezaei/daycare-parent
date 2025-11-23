import 'package:parent_app/core/network/dio_client.dart';
import '../../domain/entities/billing_entity.dart';
import '../../domain/repositories/billing_repository.dart';

class BillingRepositoryImpl implements BillingRepository {
  final DioClient dioClient;

  BillingRepositoryImpl(this.dioClient);

  @override
  Future<List<BillingEntity>> getBillings(String childId) async {
    final response = await dioClient.get(
      '/items/Invoice',
      queryParameters: {
        'filter[child_id][_eq]': childId,
        "sort": "-date_created"
      },
    );

    final List data = response.data['data'];

    return data.map((json) {
      return BillingEntity(
        balanceMinor: json['balance_minor'] ?? 0,
        status: json['status'] ?? "",
        dueDate:
        json['due_date'] != null ? DateTime.parse(json['due_date']) : null,
      );
    }).toList();
  }
}
