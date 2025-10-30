



import '../../../domain/entities/learing_plan_entities.dart';

class LearningPlanModelModel extends LearningPlanEntity {
  LearningPlanModelModel({
    required String title,
    required String category,
    required String description,
    required List<String> tags,
  }) : super(title: title, category: category,description: description, tags: tags);

  factory LearningPlanModelModel.fromJson(Map<String, dynamic> json) {
    return LearningPlanModelModel(
      title: json['Title'] ?? '',
      category: json['Category'] ?? '',
      description: json['Description'] ?? '',
      tags: json['Tags'] != null ? List<String>.from(json['Tags']) : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Title': title,
      'Category': category,
      'Description':description,
      'Tags': tags,
    };
  }
}
