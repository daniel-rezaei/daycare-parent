import 'package:collection/collection.dart';
import '../../../../core/network/dio_client.dart';
import '../../domain/entities/child_guardian.dart';
import '../../domain/entities/guardian_banking.dart';
import '../../domain/entities/subsidy_account.dart';
import '../../domain/repository/guardian_repository.dart';

import '../models/child_guardian_model.dart';
import '../models/guardian_banking_model.dart';
import '../models/subsidy_account_model.dart';

class GuardianBankingRepositoryImpl implements GuardianRepository {
  final DioClient dio;

  GuardianBankingRepositoryImpl(this.dio);

  @override
  Future<List<ChildGuardian>> getChildGuardiansByContactId(String contactId) async {
    final resp = await dio.get('/items/Child_Guardian', queryParameters: {
      'filter[contact_id][_eq]': contactId,
      'limit': '50',
    });
    final items = resp.data['data'] as List<dynamic>? ?? [];
    return items.map((e) => ChildGuardianModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Future<List<SubsidyAccount>> getSubsidyAccountsByChildId(String childId) async {
    final resp = await dio.get('/items/Subsidy_Account', queryParameters: {
      'filter[child_id][_eq]': childId,
      'filter[Status][_eq]': 'active',
      'limit': '50',
    });
    final items = resp.data['data'] as List<dynamic>? ?? [];
    return items.map((e) => SubsidyAccountModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Future<GuardianBanking?> getGuardianBankingByGuardianId(String guardianId) async {
    final resp = await dio.get('/items/guardian_banking', queryParameters: {
      'filter[guardian_id][_eq]': guardianId,
      'limit': '1',
    });
    final items = resp.data['data'] as List<dynamic>? ?? [];
    if (items.isEmpty) return null;
    return GuardianBankingModel.fromJson(items.first as Map<String, dynamic>);
  }

  @override
  Future<GuardianBanking?> getGuardianBankingByContactId(String contactId) async {
    // ابتدا guardianId از جدول Child_Guardian
    final cgs = await getChildGuardiansByContactId(contactId);
    final withGuardianId = cgs.firstWhereOrNull(
            (c) => c.guardianId != null && c.guardianId!.isNotEmpty);

    if (withGuardianId != null) {
      final banking = await getGuardianBankingByGuardianId(withGuardianId.guardianId!);
      if (banking != null) return banking;
    }

    // GuardianId نال است → اجازه دسترسی نیست
    print('⚠️ No guardianId found for contactId $contactId. Access denied.');
    return null; // به جای fallback خطرناک، null برگردان
  }

  @override
  Future<void> updateGuardianConsent({
    required String guardianId,
    required bool consent,
  }) async {
    if (guardianId.isEmpty) {
      print('⚠️ Cannot update consent: guardianId is null or empty.');
      return;
    }

    try {
      final bankingResp = await dio.get(
        '/items/guardian_banking',
        queryParameters: {
          'filter[guardian_id][_eq]': guardianId,
          'limit': 1,
        },
      );

      final bankingData = bankingResp.data['data'] as List<dynamic>? ?? [];
      if (bankingData.isEmpty) {
        print('⚠️ No guardian_banking record found for guardianId: $guardianId');
        return;
      }

      final bankingId = bankingData.first['id'];
      await dio.patch(
        '/items/guardian_banking/$bankingId',
        data: {
          'consent': consent,
          'consent_at_': DateTime.now().toIso8601String(),
        },
      );

      print('✅ Guardian consent updated for $guardianId.');
    } catch (e) {
      print('❌ Error updating guardian consent: $e');
      rethrow;
    }
  }
}

