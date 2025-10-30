
import 'dart:convert';

import '../../features/home_page/data/model/parent_contact_model.dart';
import '../../features/home_page/domain/entities/parent_contact_entity.dart';
import 'dio_client.dart';

extension ParentApi on DioClient {
  /// 1. گرفتن contact_id والد از Users
  Future<String?> getParentContactId(String currentUserId) async {
    try {
      final resp = await get('/items/Users', queryParameters: {
        // فیلتر را JSON encode می‌کنیم تا همیشه با Directus سازگار باشد
        'filter': jsonEncode({
          'id': {'_eq': currentUserId}
        })
      });

      print('Users response: ${resp.data}'); // debug

      final users = resp.data['data'] as List<dynamic>?;
      if (users == null || users.isEmpty) {
        print('No user found with id: $currentUserId');
        return null;
      }

      final user = users.first as Map<String, dynamic>;
      final contactId = user['contact_id'];
      print('Parent contact_id: $contactId'); // debug

      if (contactId == null) return null;
      return contactId is Map ? contactId['id'] : contactId.toString();
    } catch (e) {
      print('Error fetching parent contact_id: $e');
      return null;
    }
  }

  /// 2. گرفتن اطلاعات کانتکت والد
  Future<ParentContactEntity?> getParentContact(String parentContactId) async {
    try {
      final resp = await get('/items/Contacts/$parentContactId');

      print('Contact response: ${resp.data}'); // debug

      // چون پاسخ یک Map است نه List
      final data = resp.data['data'] as Map<String, dynamic>?;

      if (data == null) {
        print('No contact found with id: $parentContactId');
        return null;
      }

      print('Contact JSON: $data'); // debug
      return ParentContactModel.fromJson(data);
    } catch (e) {
      print('Error fetching parent contact: $e');
      return null;
    }
  }


  /// 3. بررسی اینکه والد سرپرست یک فرزند است (اختیاری)
  Future<bool> verifyParentForChild(String parentContactId, String childId) async {
    try {
      final resp = await get('/items/Child_Guardian', queryParameters: {
        'filter': jsonEncode({
          'child_id': {'_eq': childId},
          'guardian.contact_id': {'_eq': parentContactId}
        }),
        'limit': 1
      });

      final list = resp.data['data'] as List<dynamic>?;
      return list != null && list.isNotEmpty;
    } catch (e) {
      print('Error verifying parent for child: $e');
      return false;
    }
  }
}
