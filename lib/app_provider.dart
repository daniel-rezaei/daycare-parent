
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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


import 'core/constants.dart';
import 'features/billing/data/repository/billing_summery_impl.dart';
import 'features/billing/domain/usecase/get_billing_summery_usecase.dart';
import 'features/billing/presentation/bloc/billing_summery_bloc.dart';
import 'features/billing/presentation/bloc/billing_summery_event.dart';
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
import 'features/login/data/repository/auth_repository_impl.dart';
import 'features/login/domain/usecase/login_usecase.dart';
import 'features/login/presentation/bloc/auth_bloc.dart';
import 'features/parent_profile/data/repository/guardian_banking_repository_impl.dart';
import 'features/parent_profile/data/repository/subsidy_account_repository_impl.dart';
import 'features/parent_profile/domain/usecases/get_guading_bank_usecase.dart';
import 'features/parent_profile/domain/usecases/get_subsidy_usecase.dart';
import 'features/parent_profile/domain/usecases/update_guardian_banking_usecase.dart';
import 'features/parent_profile/presentation/bloc/guardian_banking_bloc.dart';
import 'features/parent_profile/presentation/bloc/guardian_banking_event.dart';
import 'features/parent_profile/presentation/bloc/parent_profile_bloc.dart';
import 'features/parent_profile/presentation/bloc/parent_profile_event.dart';
import 'features/parent_profile/presentation/bloc/subsidy_bloc.dart';

List<BlocProvider> buildAppProviders() {
  final dioClient = DioClient();

  return [

    BlocProvider<LoginBloc>(
      create: (_) => LoginBloc(
        LoginUseCase(LoginRepositoryImpl(DioClient())),
      ),
    ),
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
      ), // ❌ دیگر نیازی نیست LoadAttendanceChild بدون childId فراخوانی شود
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
    BlocProvider<BillingSummeryBloc>(
      create: (_) => BillingSummeryBloc(
        GetBillingSummaryUseCase(
          BillingSummeryRepositoryImpl(dioClient),
        ),
      )..add(LoadBillingSummaryEvent()),
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
  currentUserId: parentContactId)),

  ),
    BlocProvider<ParentProfileBloc>(
      create: (_) => ParentProfileBloc(
        ParentRepositoryImpl(dioClient),
      )..add(
        LoadParentProfileEvent(parentId: parentContactId),
      ),
    ),
    BlocProvider<GuardianBankingBloc>(
      create: (_) => GuardianBankingBloc(
        getUseCase: GetGuardianBankingUseCase(
          GuardianBankingRepositoryImpl(dioClient),
        ),
        updateConsentUseCase: UpdateGuardianConsentUseCase(
          GuardianBankingRepositoryImpl(dioClient),
        ),
      ),
    ),
    BlocProvider<SubsidyBloc>(
      create: (_) => SubsidyBloc(
        GetSubsidyUseCase(
          SubsidyRepositoryImpl(dioClient),
        ),
      ),
    ),
    BlocProvider<ChildBloc>(
      create: (_) => ChildBloc(
          GetChildDataUseCase(
              ChildRepositoryImpl(dioClient)))
        ..add(LoadChildData()),

    )
  ];
}
