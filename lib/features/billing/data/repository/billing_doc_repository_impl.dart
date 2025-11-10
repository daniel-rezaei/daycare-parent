import 'package:parent_app/features/billing/domain/entity/billing_doc_entity.dart';
import 'package:parent_app/features/billing/domain/repository/billing_doc_repository.dart';
import '../../../../core/network/dio_client.dart';
import '../model/billing_doc_model.dart';

class BillingDocRepositoryImpl implements BillingDocRepository {
  final DioClient dioClient;

  BillingDocRepositoryImpl({required this.dioClient});

  final String basePath = '/items/Billing_Documents';
  final String guardianAccountsPath = '/items/billing_account_guardian';

  /// گرفتن همه billing_account_id های مربوط به guardian
  Future<List<int>> _getBillingAccounts(String guardianId) async {
    final res = await dioClient.get(guardianAccountsPath, queryParameters: {
      'filter[guardian_id][_eq]': guardianId,
    });

    final data = res.data['data'] as List<dynamic>;
    if (data.isEmpty) return [];

    List<int> accounts = [];
    for (var item in data) {
      final ids = (item['billing_account_id'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList() ??
          [];
      accounts.addAll(ids);
    }
    return accounts;
  }

  /// پیدا کردن اولین سند statement یا tax statement
  Future<BillingDocumentEntity?> _getFirstDoc(
      List<int> accounts, String type) async {
    if (accounts.isEmpty) return null;

    final response = await dioClient.get(basePath, queryParameters: {
      'filter[billing_account_id][_in]': accounts, // ✅ فقط لیست
      'sort': ['-period_end'],
      'limit': 100,
    });

    final data = response.data['data'] as List<dynamic>;

    final doc = data.firstWhere(
          (d) {
        final docKind = d['doc_kind']?.toString().toLowerCase() ?? '';
        return docKind.contains(type.toLowerCase());
      },
      orElse: () => null,
    );

    if (doc == null) return null;
    return BillingDocumentModel.fromJson(doc);
  }

  @override
  Future<BillingDocumentEntity?> getLatestStatement(String guardianId) async {
    final accounts = await _getBillingAccounts(guardianId);
    if (accounts.isEmpty) return null;

    return await _getFirstDoc(accounts, 'statement');
  }

  @override
  Future<List<int>> getTaxStatementYears(String guardianId) async {
    final accounts = await _getBillingAccounts(guardianId);
    if (accounts.isEmpty) return [];

    final response = await dioClient.get(basePath, queryParameters: {
      'filter[billing_account_id][_in]': accounts,
      'sort': ['-period_end'],
      'limit': 100,
    });

    final data = response.data['data'] as List<dynamic>;
    final years = <int>{};

    for (var d in data) {
      final docKind = d['doc_kind']?.toString().toLowerCase() ?? '';
      if (!docKind.contains('tax')) continue;

      final startStr = d['period_start']?.toString();
      final endStr = d['period_end']?.toString();
      if (startStr == null || endStr == null) continue;

      final startYear = DateTime.tryParse(startStr)?.year;
      final endYear = DateTime.tryParse(endStr)?.year;
      if (startYear == null || endYear == null) continue;

      for (var y = startYear; y <= endYear; y++) {
        years.add(y);
      }
    }

    final sortedYears = years.toList()..sort((a, b) => b.compareTo(a));
    return sortedYears;
  }

  @override
  Future<BillingDocumentEntity?> getTaxStatementByYear(
      String guardianId, int year) async {
    final accounts = await _getBillingAccounts(guardianId);
    if (accounts.isEmpty) return null;

    final response = await dioClient.get(basePath, queryParameters: {
      'filter[billing_account_id][_in]': accounts, // ✅ فقط لیست
      'sort': ['-period_end'],
      'limit': 100,
    });

    final data = response.data['data'] as List<dynamic>;

    final doc = data.firstWhere((d) {
      final docKind = d['doc_kind']?.toString().toLowerCase() ?? '';
      if (!docKind.contains('tax')) return false;

      final startStr = d['period_start']?.toString();
      final endStr = d['period_end']?.toString();
      if (startStr == null || endStr == null) return false;

      final startYear = DateTime.tryParse(startStr)?.year;
      final endYear = DateTime.tryParse(endStr)?.year;
      if (startYear == null || endYear == null) return false;

      return year >= startYear && year <= endYear;
    }, orElse: () => null);

    if (doc == null) return null;
    return BillingDocumentModel.fromJson(doc);
  }
}
