import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';
import '../../domain/repository/auth_repository.dart';
import '../model/user_model.dart';

class LoginRepositoryImpl implements AuthRepository {
  final DioClient dioClient;

  LoginRepositoryImpl(this.dioClient);

  @override
  Future<UserModel?> login(String email, String password) async {
    try {
      // مرحله ۱: گرفتن اطلاعات User
      final response = await dioClient.get('/items/Users');
      final users = (response.data['data'] as List)
          .map((e) => e as Map<String, dynamic>)
          .toList();

      final userJson = users.firstWhere(
            (u) => (u['email'] as String).toLowerCase() == email.toLowerCase(),
        orElse: () => {},
      );

      if (userJson.isEmpty) return null;

      final contactId = userJson['contact_id'];
      Map<String, dynamic>? contactJson;

      // مرحله ۲: گرفتن اطلاعات Contact
      if (contactId != null && contactId.toString().isNotEmpty) {
        final contactRes = await dioClient.get('/items/Contacts');
        final contacts = (contactRes.data['data'] as List)
            .map((e) => e as Map<String, dynamic>)
            .toList();

        contactJson = contacts.firstWhere(
              (c) => c['id'] == contactId,
          orElse: () => {},
        );
      }

      // 👇 مرحله ۳: گرفتن Guardian مربوط به contact_id
      String? guardianId;
      if (contactId != null && contactId.toString().isNotEmpty) {
        final guardianRes = await dioClient.get('/items/Guardian');
        final guardians = (guardianRes.data['data'] as List)
            .map((e) => e as Map<String, dynamic>)
            .toList();

        final guardian = guardians.firstWhere(
              (g) => g['contact_id'] == contactId,
          orElse: () => {},
        );

        guardianId = guardian.isNotEmpty ? guardian['id'] : null;
      }

      // مرحله ۴: ساخت مدل User با Guardian ID
      return UserModel.fromJson(userJson, contactJson, guardianId);
    } catch (e) {
      rethrow;
    }
  }

}
