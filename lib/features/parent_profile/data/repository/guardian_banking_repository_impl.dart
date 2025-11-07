// data/repositories/guardian_banking_repository_impl.dart
import '../../../../core/network/dio_client.dart';
import '../../domain/entities/guardian_banking_entity.dart';
import '../../domain/repository/guardian_banking_repository.dart';
import '../models/guardian_banking_model.dart';

class GuardianBankingRepositoryImpl implements GuardianBankingRepository {
  final DioClient dio;
  GuardianBankingRepositoryImpl(this.dio);

  @override
  Future<GuardianBankingEntity?> fetchByGuardianId(String guardianId) async {
    final res = await dio.get('/items/guardian_banking', queryParameters: {
      'filter[guardian_id][_eq]': guardianId,
    });

    final data = res.data?['data'] as List?;
    if (data == null || data.isEmpty) return null;

    return GuardianBankingModel.fromJson(data.first);
  }

  @override
  Future<void> updateConsent(String bankingRecordId, bool consent) async {
    final payload = {
      'consent': consent,
      'consent_at_': consent ? DateTime.now().toIso8601String() : null,
    };
    await dio.patch('/items/guardian_banking/$bankingRecordId', data: payload);
  }

  @override
  Future<void> updateBankInfo(String bankingRecordId, {
    String? accountNumber,
    String? transitNumber,
    String? institutionNumber,
  }) async {
    final payload = <String, dynamic>{};
    if (accountNumber != null) payload['account_number'] = accountNumber;
    if (transitNumber != null) payload['transit_number'] = transitNumber;
    if (institutionNumber != null) payload['institution_number'] = institutionNumber;

    await dio.patch('/items/guardian_banking/$bankingRecordId', data: payload);
  }
}
