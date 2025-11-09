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

      // مرحله ۲: گرفتن اطلاعات Contact از contact_id
      if (contactId != null && contactId.toString().isNotEmpty) {
        final contactRes = await dioClient.get('/items/Contacts');
        final contacts = (contactRes.data['data'] as List)
            .map((e) => e as Map<String, dynamic>)
            .toList();

        // پیدا کردن contact مرتبط با user
        contactJson = contacts.firstWhere(
              (c) => c['id'] == contactId,
          orElse: () => {},
        );
      }

      // مرحله ۳: ساخت مدل کامل
      return UserModel.fromJson(userJson, contactJson);
    } catch (e) {
      rethrow;
    }
  }
}
