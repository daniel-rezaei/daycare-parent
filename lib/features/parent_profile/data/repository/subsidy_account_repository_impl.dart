// data/repositories/subsidy_repository_impl.dart
import '../../../../core/network/dio_client.dart';
import '../../domain/entities/subsidy_account_entity.dart';

import '../../domain/repository/subsidy_account_repository.dart';
import '../models/subsidy_account_model.dart';

class SubsidyRepositoryImpl implements SubsidyRepository {
  final DioClient dio;
  SubsidyRepositoryImpl(this.dio);

  @override
  Future<List<SubsidyAccountEntity>> fetchForGuardianOrContact(String contactId) async {
    final res = await dio.get('/items/Child_Guardian', queryParameters: {
      'filter[contact_id][_eq]': contactId,
    });

    final childData = res.data?['data'] as List?;
    if (childData == null || childData.isEmpty) return [];

    final childIds = childData
        .where((c) => c['is_primary_payer'] == true || c['is_primary_payer'] == null)
        .map((c) => c['child_id'])
        .toList();

    if (childIds.isEmpty) return [];

    final subsidyRes = await dio.get('/items/Subsidy_Account', queryParameters: {
      'filter[child_id][_in]': childIds.join(','),
    });

    final subs = subsidyRes.data?['data'] as List?;
    if (subs == null) return [];

    return subs.map((e) => SubsidyAccountModel.fromJson(e)).toList();
  }

  @override
  Future<bool> hasActiveSubsidy(String contactId) async {
    final subs = await fetchForGuardianOrContact(contactId);
    return subs.any((s) => s.isActive);
  }
}
