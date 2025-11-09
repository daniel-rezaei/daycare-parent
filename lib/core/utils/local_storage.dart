import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../features/login/data/model/user_model.dart';

class LocalStorage {
  static Future<void> saveUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('logged_in_user', jsonEncode(user.toJson()));
  }

  static Future<UserModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('logged_in_user');
    if (userJson == null) return null;

    final Map<String, dynamic> map = jsonDecode(userJson);
    return UserModel.fromPrefsJson(map);
  }

  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('logged_in_user');
  }
}
