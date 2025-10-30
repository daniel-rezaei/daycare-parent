
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parent_app/features/child_profile/data/repository/guardian_repository_impl.dart';
import 'package:parent_app/features/child_profile/domain/usecase/child_schedule_usecase.dart';
import 'package:parent_app/features/child_profile/domain/usecase/guardian_usecase.dart';
import 'package:parent_app/features/child_profile/presentation/bloc/guardian_bloc.dart';
import 'package:parent_app/features/home_page/data/repository/event_repository_impl.dart';
import 'package:parent_app/features/home_page/domain/usecase/get_event_usecase.dart';
import 'package:parent_app/features/home_page/presentation/bloc/bottom_nav_bloc.dart';
import 'package:parent_app/features/home_page/presentation/bloc/event_bloc.dart';
import 'package:parent_app/features/home_page/presentation/bloc/event_event.dart';
import 'package:parent_app/features/home_page/presentation/bloc/learning_plan_bloc.dart';
import 'package:parent_app/features/home_page/domain/usecase/get_learning_plan_usecase.dart';
import 'package:parent_app/features/home_page/data/repository/learning_plan_repository_impl.dart';
import 'package:parent_app/core/network/dio_client.dart';


import 'features/child_profile/data/repository/child_schedule_repository_impl.dart';
import 'features/child_profile/data/repository/emergency_repository_contact_impl.dart';
import 'features/child_profile/data/repository/health_repository_impl.dart';
import 'features/child_profile/data/repository/pick_up_repository_impl.dart';
import 'features/child_profile/domain/usecase/get_emergency_contact_usecase.dart';
import 'features/child_profile/domain/usecase/get_health_usecase.dart';
import 'features/child_profile/domain/usecase/get_pickup_usecase.dart';
import 'features/child_profile/presentation/bloc/child_schedule_bloc.dart';
import 'features/child_profile/presentation/bloc/child_schedule_event.dart';
import 'features/child_profile/presentation/bloc/emergency_contacts_bloc.dart';
import 'features/child_profile/presentation/bloc/health_bloc.dart';
import 'features/child_profile/presentation/bloc/pick_up_bloc.dart';
import 'features/home_page/data/repository/attendance_repository_impl.dart';
import 'features/home_page/data/repository/billing_repository_impl.dart';
import 'features/home_page/data/repository/child_repository_impl.dart';
import 'features/home_page/data/repository/meal_plan_repository_impl.dart';
import 'features/home_page/data/repository/parent_repository_impl.dart';
import 'features/home_page/domain/usecase/get_attendance_usecase.dart';
import 'features/home_page/domain/usecase/get_billing_usecase.dart';
import 'features/home_page/domain/usecase/get_child_usecase.dart';
import 'features/home_page/domain/usecase/get_meal_plan_usecase.dart';
import 'features/home_page/domain/usecase/get_parent_contact_usecase.dart';
import 'features/home_page/presentation/bloc/attendance_bloc.dart';
import 'features/home_page/presentation/bloc/attendance_event.dart';
import 'features/home_page/presentation/bloc/billing_bloc.dart';
import 'features/home_page/presentation/bloc/child_bloc.dart';
import 'features/home_page/presentation/bloc/child_event.dart';
import 'features/home_page/presentation/bloc/learning_plan_event.dart';
import 'features/home_page/presentation/bloc/meal_plan_bloc.dart';
import 'features/home_page/presentation/bloc/meal_plan_event.dart';
import 'features/home_page/presentation/bloc/parent_contact_bloc.dart';
import 'features/home_page/presentation/bloc/parent_contact_event.dart';

List<BlocProvider> buildAppProviders() {
  final dioClient = DioClient();


  return [
    BlocProvider<BottomNavBloc>(
      create: (_) => BottomNavBloc(),
    ),
    BlocProvider<LearningPlanBloc>(
      create: (_) => LearningPlanBloc(
        GetLearningPlanUseCase(LearningPlanRepositoryImpl(dioClient)),
      ),
    ),

    BlocProvider<MealPlanBloc>(
      create: (_) => MealPlanBloc(
        GetMealPlanUseCase(
          MealPlanRepositoryImpl(dioClient),
        ),
      )..add(LoadMeals()),
    ),
    BlocProvider<AttendanceChildBloc>(
      create: (_) => AttendanceChildBloc(
        GetAttendanceChildUseCase(
          AttendanceChildRepositoryImpl(dioClient),
        ),
      )..add(LoadAttendanceChild()),
    ),

    BlocProvider<EventBloc>(
      create: (_) => EventBloc(
        GetEventUseCase(
          EventRepositoryImpl(dioClient),
        ),
      )..add(LoadEvents()),
    ),
    BlocProvider<BillingBloc>(
      create: (_) => BillingBloc(
        GetBillingUseCase(
          BillingRepositoryImpl(DioClient()),
        ),
      )..add(LoadBilling()),
    ),

    BlocProvider<ChildScheduleBloc>(
      create: (_) => ChildScheduleBloc(
        GetChildScheduleUseCase(
          ChildScheduleRepositoryImpl(DioClient()),
        ),
      )..add(LoadChildSchedule()),
    ),

    BlocProvider<GuardianBloc>(
      create: (_) => GuardianBloc(
        GetPrimaryGuardiansUseCase(
          GuardianRepositoryImpl(DioClient()),
        ),
      ),
    ),
    BlocProvider<EmergencyContactsBloc>(
      create: (context) => EmergencyContactsBloc(
        getContacts: GetEmergencyContacts(
          EmergencyContactRepositoryImpl( dioClient: dioClient),
        ),
        getContactsCount: GetEmergencyContactsCount(
          EmergencyContactRepositoryImpl(dioClient: dioClient),
        ),
      ),
    ),
    BlocProvider<PickupBloc>(
      create: (_) => PickupBloc(
        GetAuthorizedPickups(
          PickupRepositoryImpl(dioClient),
        ),
      ),
    ),
    BlocProvider<HealthBloc>(
      create: (_) => HealthBloc(
        allergyUseCase: GetAllergyDataUseCase(HealthRepositoryImpl(dioClient)),
        dietaryUseCase: GetDietaryDataUseCase(HealthRepositoryImpl(dioClient)),
        medicationUseCase: GetMedicationDataUseCase(HealthRepositoryImpl(dioClient)),
        immunizationUseCase: GetImmunizationDataUseCase(HealthRepositoryImpl(dioClient)),
        physicalUseCase: GetPhysicalReqDataUseCase(HealthRepositoryImpl(dioClient)),
        diseaseUseCase: GetReportableDiseaseDataUseCase(HealthRepositoryImpl(dioClient)),
      ),
    ),


    BlocProvider<ParentContactBloc>(
  create: (_) => ParentContactBloc(
  GetParentContactUseCase(
  ParentRepositoryImpl(dioClient),
  ),
  )..add(LoadParentContact(
  currentUserId: "6800caf4-6754-44dd-a202-bc8d90dca01e")),
  // childId هم می‌توانید پاس دهید اگر لازم است
  ),
    BlocProvider<ChildBloc>(
      create: (_) => ChildBloc(
          GetChildDataUseCase(
              ChildRepositoryImpl(dioClient)))
        ..add(LoadChildData()),

    )
  ];
}
