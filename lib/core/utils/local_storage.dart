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

  // ذخیره کل یوزرها
  static Future<void> saveAllUsersJson(List<dynamic> users) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('all_users', jsonEncode(users));
  }

  static Future<List<Map<String, dynamic>>> getAllUsersJson() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString('all_users');
    if (jsonStr == null) return [];
    final list = jsonDecode(jsonStr) as List;
    return list.map((e) => e as Map<String, dynamic>).toList();
  }

  // ذخیره کل کانتکت‌ها
  static Future<void> saveAllContactsJson(List<dynamic> contacts) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('all_contacts', jsonEncode(contacts));
  }

  static Future<List<Map<String, dynamic>>> getAllContactsJson() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString('all_contacts');
    if (jsonStr == null) return [];
    final list = jsonDecode(jsonStr) as List;
    return list.map((e) => e as Map<String, dynamic>).toList();
  }

}
