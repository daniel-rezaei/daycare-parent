
import '../../domain/entity/child_health_entity.dart';

class AllergyModel extends AllergyEntity {
  AllergyModel({required super.allergenName});

  factory AllergyModel.fromJson(Map<String, dynamic> json) {
    return AllergyModel(allergenName: json['allergen_name']);
  }
}

class DietaryRestrictionModel extends DietaryRestrictionEntity {
  DietaryRestrictionModel({required super.restrictionName});

  factory DietaryRestrictionModel.fromJson(Map<String, dynamic> json) {
    return DietaryRestrictionModel(restrictionName: json['restriction_name']);
  }
}

class MedicationModel extends MedicationEntity {
  MedicationModel({required super.medicationName});

  factory MedicationModel.fromJson(Map<String, dynamic> json) {
    return MedicationModel(medicationName: json['medication_name']);
  }
}

class ImmunizationModel extends ImmunizationEntity {
  ImmunizationModel({required super.vaccineName});

  factory ImmunizationModel.fromJson(Map<String, dynamic> json) {
    return ImmunizationModel(vaccineName: json['VaccineName']);
  }
}

class PhysicalRequirementModel extends PhysicalRequirementEntity {
  PhysicalRequirementModel({required super.requirementName});

  factory PhysicalRequirementModel.fromJson(Map<String, dynamic> json) {
    return PhysicalRequirementModel(requirementName: json['requirement_name']);
  }
}

class ReportableDiseaseModel extends ReportableDiseaseEntity {
  ReportableDiseaseModel({required super.diseaseName});

  factory ReportableDiseaseModel.fromJson(Map<String, dynamic> json) {
    return ReportableDiseaseModel(diseaseName: json['disease_name']);
  }
}
