import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/utils/local_storage.dart';
import '../../domain/repository/auth_repository.dart';
import '../model/user_model.dart';

class LoginRepositoryImpl implements AuthRepository {
  final DioClient dioClient;

  LoginRepositoryImpl(this.dioClient);

  @override
  Future<UserModel?> login(String email, String password) async {
    try {
      // مرحله ۱: گرفتن اطلاعات Users
      final response = await dioClient.get('/items/Users');
      final users = (response.data['data'] as List)
          .map((e) => e as Map<String, dynamic>)
          .toList();

      // ذخیره همه یوزرها
      await LocalStorage.saveAllUsersJson(users);

      // پیدا کردن کاربر لاگین شده
      final userJson = users.firstWhere(
            (u) => (u['email'] as String).toLowerCase() == email.toLowerCase(),
        orElse: () => {},
      );
      if (userJson.isEmpty) return null;

      final contactId = userJson['contact_id'];
      Map<String, dynamic>? contactJson;

      // مرحله ۲: گرفتن Contacts
      final contactRes = await dioClient.get('/items/Contacts');
      final contacts = (contactRes.data['data'] as List)
          .map((e) => e as Map<String, dynamic>)
          .toList();

      // ذخیره همه کانتکت‌ها
      await LocalStorage.saveAllContactsJson(contacts);

      if (contactId != null && contactId.toString().isNotEmpty) {
        contactJson = contacts.firstWhere(
              (c) => c['id'] == contactId,
          orElse: () => {},
        );
      }

      // مرحله ۳: گرفتن Guardian مربوط به contact_id
      String? guardianId;
      final guardianRes = await dioClient.get('/items/Guardian');
      final guardians = (guardianRes.data['data'] as List)
          .map((e) => e as Map<String, dynamic>)
          .toList();

      if (contactId != null && contactId.toString().isNotEmpty) {
        final guardian = guardians.firstWhere(
              (g) => g['contact_id'] == contactId,
          orElse: () => {},
        );
        guardianId = guardian.isNotEmpty ? guardian['id'] : null;
      }

      // مرحله ۴: ساخت مدل User با Guardian ID
      final loggedInUser = UserModel.fromJson(userJson, contactJson, guardianId);

      // ذخیره کاربر لاگین شده
      await LocalStorage.saveUser(loggedInUser);

      return loggedInUser;
    } catch (e) {
      rethrow;
    }
  }
}

