import '../../domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.email,
    required super.status,
    super.contactId,
    required super.firstName,
    required super.lastName,
    required super.phone,
    required super.address,
    required super.postalCode,
    required super.photo,
  });

  /// ساخت مدل از JSON دریافتی از API
  factory UserModel.fromJson(
      Map<String, dynamic> json, [
        Map<String, dynamic>? contactJson,
      ]) {
    // اولویت بندی برای گرفتن شماره تلفن
    String phone = '';
    if (contactJson != null) {
      phone = contactJson['Phone'] ?? contactJson['phone'] ?? '';
    }
    if (phone.isEmpty) {
      phone = json['Phone'] ?? json['phone'] ?? '';
    }

    // چاپ برای دیباگ
    print("DEBUG phone: $phone");

    return UserModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      status: json['status'] ?? '',
      contactId: json['contact_id'] ?? json['contactId'] ?? '',
      firstName: contactJson?['first_name'] ?? json['first_name'] ?? '',
      lastName: contactJson?['last_name'] ?? json['last_name'] ?? '',
      phone: phone,
      address: contactJson?['street_address'] ?? json['street_address'] ?? '',
      postalCode: contactJson?['postal_code'] ?? json['postal_code'] ?? '',
      photo: contactJson?['photo'] ?? json['photo'] ?? '',
    );
  }

  /// ساخت مدل از JSON ذخیره شده در SharedPreferences
  factory UserModel.fromPrefsJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      status: json['status'] ?? '',
      contactId: json['contactId'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      phone: json['phone'] ?? json['Phone'] ?? '',
      address: json['address'] ?? '',
      postalCode: json['postalCode'] ?? '',
      photo: json['photo'] ?? '',
    );
  }

  /// تبدیل مدل به JSON برای ذخیره یا ارسال
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'status': status,
      'contactId': contactId,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'address': address,
      'postalCode': postalCode,
      'photo': photo,
    };
  }
}
