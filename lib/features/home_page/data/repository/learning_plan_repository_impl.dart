import 'package:intl/intl.dart';
import '../../../../core/network/dio_client.dart';
import '../../domain/entities/learing_plan_entities.dart';
import '../../domain/repositories/learning_plan_repository.dart';
import '../model/learning_plan/learning_plan_model.dart';


class LearningPlanRepositoryImpl implements LearningPlanRepository {
  final DioClient dioClient;

  LearningPlanRepositoryImpl(this.dioClient);

  @override
  Future<List<LearningPlanEntity>> getPlan({required String ageGroupId}) async {
    // فقط تاریخ بدون ساعت
    final todayStr = DateFormat('yyyy-MM-dd').format(DateTime.now());
    print('🟣 Fetching plans for ageGroupId=$ageGroupId on $todayStr');

    final response = await dioClient.get(
      '/items/Learning_Plan',
      queryParameters: {
        // 🔸 استفاده از نام دقیق فیلدها با حرف بزرگ
        'filter[Start_Date][_lte]': todayStr,
        'filter[End_Date][_gte]': todayStr,
        'filter[age_group_id][_eq]': ageGroupId,
      },
    );

    print('🟢 Response raw data: ${response.data}');

    final data = response.data['data'] as List;
    return data.map((json) => LearningPlanModelModel.fromJson(json)).toList();
  }
}
