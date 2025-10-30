import '../repository/health_repository.dart';

class GetAllergyDataUseCase {
  final HealthRepository repo;
  GetAllergyDataUseCase(this.repo);

  Future<int> getCount(String childId) => repo.getAllergyCount(childId);
  Future getList(String childId) => repo.getAllergies(childId);
}

class GetDietaryDataUseCase {
  final HealthRepository repo;
  GetDietaryDataUseCase(this.repo);

  Future<int> getCount(String childId) => repo.getDietaryCount(childId);
  Future getList(String childId) => repo.getDietaries(childId);
}

class GetMedicationDataUseCase {
  final HealthRepository repo;
  GetMedicationDataUseCase(this.repo);

  Future<int> getCount(String childId) => repo.getMedicationCount(childId);
  Future getList(String childId) => repo.getMedications(childId);
}

class GetImmunizationDataUseCase {
  final HealthRepository repo;
  GetImmunizationDataUseCase(this.repo);

  Future<int> getCount(String childId) => repo.getImmunizationCount(childId);
  Future getList(String childId) => repo.getImmunizations(childId);
}

class GetPhysicalReqDataUseCase {
  final HealthRepository repo;
  GetPhysicalReqDataUseCase(this.repo);

  Future<int> getCount(String childId) => repo.getPhysicalReqCount(childId);
  Future getList(String childId) => repo.getPhysicalRequirements(childId);
}

class GetReportableDiseaseDataUseCase {
  final HealthRepository repo;
  GetReportableDiseaseDataUseCase(this.repo);

  Future<int> getCount(String childId) => repo.getReportableDiseaseCount(childId);
  Future getList(String childId) => repo.getReportableDiseases(childId);
}
