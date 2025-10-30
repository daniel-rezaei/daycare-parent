



import '../../domain/entities/child_entity.dart';

class ContactModel extends ContactEntity {
  ContactModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.role,
    super.phone,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      id: json['id'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      role: json['Role'] ?? '',
      phone: json['Phone'],
    );
  }
}



class ClassModel extends ClassEntity {
  ClassModel({
    required super.id,
    required super.roomName,
    required super.ageGroup,
    required super.ageGroupId,
    required super.lowerAgeYears,
    required super.upperAgeYears,
  });

  factory ClassModel.fromJson(Map<String, dynamic> json) {
    return ClassModel(
      id: json['id'] ?? '',
      roomName: json['room_name'] ?? '',
      ageGroup: json['age_group'] ?? '',
      ageGroupId: json['age_group_id'] ?? '',
      lowerAgeYears: json['Lower_Age_Years'] ?? 0,
      upperAgeYears: json['Upper_Age_Years'] ?? 0,
    );
  }
}


class ChildModel extends ChildEntity {
  ChildModel({
    required super.id,
    super.dob,
    required super.photo,
    required super.contacts,
    required super.classes,
  });

  factory ChildModel.fromJson(Map<String, dynamic> json) {
    // --- CONTACTS ---
    List<ContactModel> contacts = [];
    final contactData = json['contact_id'];

    if (contactData is List) {
      // حالت: [ { Contacts_id: {...} }, { Contacts_id: {...} } ]
      contacts = contactData.map((e) {
        if (e is Map && e.containsKey('Contacts_id')) {
          final contactJson = e['Contacts_id'];
          if (contactJson is Map) {
            return ContactModel.fromJson(Map<String, dynamic>.from(contactJson));
          }
        }
        return ContactModel(
          id: e.toString(),
          firstName: '',
          lastName: '',
          role: '',
        );
      }).toList();
    } else if (contactData is Map) {
      // حالت: { id: ..., first_name: ... } یا { Contacts_id: {...} }
      if (contactData.containsKey('Contacts_id')) {
        contacts = [ContactModel.fromJson(Map<String, dynamic>.from(contactData['Contacts_id']))];
      } else {
        contacts = [ContactModel.fromJson(Map<String, dynamic>.from(contactData))];
      }
    } else if (contactData is String && contactData.isNotEmpty) {
      // ✅ حالت رشته‌ای
      contacts = [
        ContactModel(
          id: contactData,
          firstName: '',
          lastName: '',
          role: '',
        ),
      ];
    }

    // --- CLASSES ---
    List<ClassModel> classes = [];
    final roomData = json['primary_room_id'];

    if (roomData is List) {
      classes = roomData.map((e) {
        if (e is Map && e.containsKey('Class_id')) {
          final classJson = e['Class_id'];
          if (classJson is Map) {
            return ClassModel.fromJson(Map<String, dynamic>.from(classJson));
          }
        }
        return ClassModel(
          id: e.toString(),
          roomName: '',
          ageGroup: '',
          ageGroupId: '',
          lowerAgeYears: 0,
          upperAgeYears: 0,
        );
      }).toList();
    } else if (roomData is Map) {
      if (roomData.containsKey('Class_id')) {
        classes = [ClassModel.fromJson(Map<String, dynamic>.from(roomData['Class_id']))];
      } else {
        classes = [ClassModel.fromJson(Map<String, dynamic>.from(roomData))];
      }
    } else if (roomData is String && roomData.isNotEmpty) {
      // ✅ حالت رشته‌ای
      classes = [
        ClassModel(
          id: roomData,
          roomName: '',
          ageGroup: '',
          ageGroupId: '',
          lowerAgeYears: 0,
          upperAgeYears: 0,
        ),
      ];
    }

    return ChildModel(
      id: json['id'] ?? '',
      photo: json['photo'],
      dob: json['dob'] != null ? DateTime.tryParse(json['dob']) : null,
      contacts: contacts,
      classes: classes,
    );
  }



}




