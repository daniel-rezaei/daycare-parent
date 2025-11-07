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
      final response = await dioClient.get('/items/Users');

      final users = (response.data['data'] as List)
          .map((e) => UserModel.fromJson(e))
          .toList();

      final user = users.firstWhere(
            (u) => u.email.toLowerCase() == email.toLowerCase(),
        orElse: () => UserModel(id: '', email: '', status: '', ),
      );

      // چون سرور رمز رو بررسی نمی‌کنه، صرفاً ایمیل چک می‌کنیم
      if (user.id.isNotEmpty) {
        return user;
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }



}
