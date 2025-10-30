


import '../../domain/entity/child_health_entity.dart';
import '../../domain/repository/health_repository.dart';
import '../model/child_health_model.dart';
import '../../../../core/network/dio_client.dart';

class HealthRepositoryImpl extends HealthRepository {
  final DioClient dioClient;
  HealthRepositoryImpl(this.dioClient);

  Future<int> _count(String url) async {
    final res = await dioClient.get(url);
    print("Data from $url: ${res.data['data']}");
    return res.data['data'].length;
  }

  @override
  Future<int> getAllergyCount(String id) async =>
      _count('/items/child_allergies?filter[child_id][_eq]=$id');

  @override
  Future<List<AllergyEntity>> getAllergies(String id) async {
    final res = await dioClient.get('/items/child_allergies?filter[child_id][_eq]=$id');
    return (res.data['data'] as List)
        .map((e) => AllergyModel.fromJson(e))
        .toList();
  }

  @override
  Future<int> getDietaryCount(String id) async =>
      _count('/items/child_dietary_restrictions?filter[child_id][_eq]=$id');

  @override
  Future<List<DietaryRestrictionEntity>> getDietaries(String id) async {
    final res = await dioClient.get('/items/child_dietary_restrictions?filter[child_id][_eq]=$id');
    return (res.data['data'] as List)
        .map((e) => DietaryRestrictionModel.fromJson(e))
        .toList();
  }

  @override
  Future<int> getMedicationCount(String id) async =>
      _count('/items/Medication?filter[child_id][_eq]=$id');

  @override
  Future<List<MedicationEntity>> getMedications(String id) async {
    final res = await dioClient.get('/items/Medication?filter[child_id][_eq]=$id');
    return (res.data['data'] as List)
        .map((e) => MedicationModel.fromJson(e))
        .toList();
  }

  @override
  Future<int> getImmunizationCount(String id) async =>
      _count('/items/Immunization?filter[child_id][_eq]=$id');

  @override
  Future<List<ImmunizationEntity>> getImmunizations(String id) async {
    final res = await dioClient.get('/items/Immunization?filter[child_id][_eq]=$id');
    return (res.data['data'] as List)
        .map((e) => ImmunizationModel.fromJson(e))
        .toList();
  }

  @override
  Future<int> getPhysicalReqCount(String id) async =>
      _count('/items/child_physical_requirements?filter[child_id][_eq]=$id');

  @override
  Future<List<PhysicalRequirementEntity>> getPhysicalRequirements(String id) async {
    final res = await dioClient.get('/items/child_physical_requirements?filter[child_id][_eq]=$id');
    return (res.data['data'] as List)
        .map((e) => PhysicalRequirementModel.fromJson(e))
        .toList();
  }

  @override
  Future<int> getReportableDiseaseCount(String id) async =>
      _count('/items/child_reportable_diseases?filter[child_id][_eq]=$id');

  @override
  Future<List<ReportableDiseaseEntity>> getReportableDiseases(String id) async {
    final res = await dioClient.get('/items/child_reportable_diseases?filter[child_id][_eq]=$id');
    return (res.data['data'] as List)
        .map((e) => ReportableDiseaseModel.fromJson(e))
        .toList();
  }
}
