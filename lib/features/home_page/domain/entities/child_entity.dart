

class ChildEntity {
  final String id;
  final DateTime? dob;
  final String? photo;
  final List<ContactEntity> contacts;
  final List<ClassEntity> classes;

  ChildEntity({
    required this.id,
    this.dob,
    this.photo,
    required this.contacts,
    required this.classes,
  });
}




class ContactEntity {
  final String id;
  final String firstName;
  final String lastName;
  final String role;
  final String? phone;

  ContactEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.role,
    this.phone,
  });
}


class ClassEntity {
  final String id;
  final String roomName;
  final String ageGroup;
  final String ageGroupId;
  final int lowerAgeYears;
  final int upperAgeYears;

  ClassEntity({
    required this.id,
    required this.roomName,
    required this.ageGroup,
    required this.ageGroupId,
    required this.lowerAgeYears,
    required this.upperAgeYears,
  });
}

