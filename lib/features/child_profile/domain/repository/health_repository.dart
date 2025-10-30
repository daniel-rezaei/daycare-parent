
import '../entity/child_health_entity.dart';

abstract class HealthRepository {
  Future<int> getAllergyCount(String childId);
  Future<List<AllergyEntity>> getAllergies(String childId);

  Future<int> getDietaryCount(String childId);
  Future<List<DietaryRestrictionEntity>> getDietaries(String childId);

  Future<int> getMedicationCount(String childId);
  Future<List<MedicationEntity>> getMedications(String childId);

  Future<int> getImmunizationCount(String childId);
  Future<List<ImmunizationEntity>> getImmunizations(String childId);

  Future<int> getPhysicalReqCount(String childId);
  Future<List<PhysicalRequirementEntity>> getPhysicalRequirements(String childId);

  Future<int> getReportableDiseaseCount(String childId);
  Future<List<ReportableDiseaseEntity>> getReportableDiseases(String childId);
}
