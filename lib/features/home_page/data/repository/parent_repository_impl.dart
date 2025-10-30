
import 'package:parent_app/core/network/extention_parent_api.dart';

import '../../../../core/network/dio_client.dart';
import '../../domain/entities/parent_contact_entity.dart';
import '../../domain/repositories/parent_repository.dart';


class ParentRepositoryImpl implements ParentRepository {
  final DioClient dioClient;

  ParentRepositoryImpl(this.dioClient);

  @override
  Future<ParentContactEntity?> getParentContactForCurrentUser({
    required String currentUserId,
    String? childId,
  }) async {
    final parentContactId = await dioClient.getParentContactId(currentUserId);
    if (parentContactId == null) return null;

    if (childId != null) {
      final isGuardian = await dioClient.verifyParentForChild(parentContactId, childId);
      if (!isGuardian) return null;
    }

    final parentContact = await dioClient.getParentContact(parentContactId);
    return parentContact;
  }
}




