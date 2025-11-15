
import 'package:flutter/material.dart';
import 'package:parent_app/features/home_page/presentation/widgets/program_plan_widgets.dart';
import '../../../login/domain/entity/user_entity.dart';
import '../bloc/attendance_bloc.dart';
import '../bloc/attendance_event.dart';
import '../bloc/billing_bloc.dart';
import '../bloc/billing_state.dart';
import '../bloc/child_bloc.dart';
import '../bloc/child_state.dart';
import '../bloc/event_bloc.dart';
import '../bloc/event_state.dart';
import '../bloc/learning_plan_bloc.dart';
import '../bloc/learning_plan_state.dart';
import '../bloc/meal_plan_bloc.dart';
import '../bloc/meal_plan_state.dart';
import '../bloc/parent_contact_bloc.dart';
import '../bloc/parent_contact_state.dart';
import '../widgets/ai_summery_widget.dart';
import '../widgets/child_info_widget.dart';
import '../widgets/header_widget.dart';
import '../widgets/profile_avator_widget.dart';

import 'package:flutter_bloc/flutter_bloc.dart';


// class HomePage extends StatefulWidget {
//   final UserEntity user; // ✅ اضافه شد
//
//   const HomePage({super.key, required this.user});
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
//   @override
//   bool get wantKeepAlive => true;
//
//   bool _isLoading(BuildContext context) {
//     final header = context.watch<ParentContactBloc>().state;
//     final child = context.watch<ChildBloc>().state;
//     final ai = context.watch<EventBloc>().state;
//     final learning = context.watch<LearningPlanBloc>().state;
//     final meals = context.watch<MealPlanBloc>().state;
//     final billing = context.watch<BillingBloc>().state;
//
//     // هرکدوم هنوز لود نشدن؟
//     return header is ParentContactLoading ||
//         child is ChildLoading ||
//         ai is EventLoading ||
//         learning is LearningPlanLoading ||
//         meals is MealPlanLoading ||
//         billing is BillingLoading;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     final isLoading = _isLoading(context);
//
//     return Scaffold(
//       body: SafeArea(
//         child: Stack(
//           children: [
//             // تصویر پس‌زمینه فقط پشت بالای صفحه
//             Image.asset(
//               'assets/images/back_ground.png',
//               width: double.infinity,
//               height: double.infinity,
//               fit: BoxFit.cover,
//             ),
//
//             if (isLoading)
//               const Center(
//                 child: CircularProgressIndicator(color: Colors.blueAccent),
//               )
//             else
//               SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//
//                      Padding(
//                       padding: EdgeInsets.all(16.0),
//                       child: HeaderWidget(user: widget.user),
//                     ),
//                     const SizedBox(height: 16),
//                     const Center(child: ProfileAvatarSelector()),
//                     const SizedBox(height: 8),
//                     Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: ChildInfoWidget(
//                         onLoaded: (childId) {
//                           context.read<AttendanceChildBloc>().add(LoadAttendanceChild(childId)); // 🔹 childId پاس داده می‌شود
//                         },
//                       ),
//                     ),
//
//
//                     const SizedBox(height: 4),
//                     const AISummaryWidget(),
//
//                     Container(
//                       width: double.infinity,
//                       color: Colors.white,
//                       child: Column(
//                         children: [
//                           BlocBuilder<ChildBloc, ChildState>(
//                             builder: (context, state) {
//                               String? ageGroupId;
//
//                               if (state is ChildLoaded && state.child.classes.isNotEmpty) {
//                                 final firstClass = state.child.classes.first;
//                                 ageGroupId = firstClass.ageGroupId;
//                               }
//
//                               print('🟢 ageGroupId sent to ProgramPlanCard = $ageGroupId');
//
//                               return ProgramPlanCard(ageGroupId: ageGroupId);
//                             },
//                           ),
//
//                           const SizedBox(height: 32),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
//
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parent_app/features/home_page/presentation/widgets/program_plan_widgets.dart';
import '../../../login/domain/entity/user_entity.dart';
import '../bloc/attendance_bloc.dart';
import '../bloc/attendance_event.dart';
import '../bloc/billing_bloc.dart';
import '../bloc/billing_state.dart';
import '../bloc/child_bloc.dart';
import '../bloc/child_state.dart';
import '../bloc/event_bloc.dart';
import '../bloc/event_state.dart';
import '../bloc/learning_plan_bloc.dart';
import '../bloc/learning_plan_state.dart';
import '../bloc/meal_plan_bloc.dart';
import '../bloc/meal_plan_state.dart';
import '../bloc/parent_contact_bloc.dart';
import '../bloc/parent_contact_state.dart';
import '../widgets/ai_summery_widget.dart';
import '../widgets/child_info_widget.dart';
import '../widgets/header_widget.dart';
import '../widgets/profile_avator_widget.dart';

import '../../../../resorces/pallete.dart';

class HomePage extends StatefulWidget {
  final UserEntity user;

  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  bool _isLoading(BuildContext context) {
    final header = context.watch<ParentContactBloc>().state;
    final child = context.watch<ChildBloc>().state;
    final ai = context.watch<EventBloc>().state;
    final learning = context.watch<LearningPlanBloc>().state;
    final meals = context.watch<MealPlanBloc>().state;
    final billing = context.watch<BillingBloc>().state;

    return header is ParentContactLoading ||
        child is ChildLoading ||
        ai is EventLoading ||
        learning is LearningPlanLoading ||
        meals is MealPlanLoading ||
        billing is BillingLoading;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final isLoading = _isLoading(context);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              'assets/images/back_ground.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),

            if (isLoading)
              const Center(
                child: CircularProgressIndicator(color: Colors.blueAccent),
              )
            else
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: HeaderWidget(user: widget.user),
                    ),
                    const SizedBox(height: 16),

                    const Center(child: ProfileAvatarSelector()),
                    const SizedBox(height: 8),

                    // 🔹 اطلاعات بچه فعلی
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: BlocBuilder<ChildBloc, ChildState>(
                        builder: (context, state) {
                          String? currentChildId;

                          if (state is ChildSelected) {
                            currentChildId = state.child.id;
                          } else if (state is ChildListLoaded) {
                            currentChildId = state.selectedChild.id;
                          }

                          if (currentChildId == null) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          return ChildInfoWidget(
                            onLoaded: (childId) {
                              context
                                  .read<AttendanceChildBloc>()
                                  .add(LoadAttendanceChild(childId));
                            },
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 4),
                    const AISummaryWidget(),

                    Container(
                      width: double.infinity,
                      color: Colors.white,
                      child: Column(
                        children: [
                          BlocBuilder<ChildBloc, ChildState>(
                            builder: (context, state) {
                              String? ageGroupId;

                              if (state is ChildSelected &&
                                  state.child.classes.isNotEmpty) {
                                ageGroupId =
                                    state.child.classes.first.ageGroupId;
                              } else if (state is ChildListLoaded &&
                                  state.selectedChild.classes.isNotEmpty) {
                                ageGroupId =
                                    state.selectedChild.classes.first.ageGroupId;
                              }

                              print(
                                  '🟢 ageGroupId sent to ProgramPlanCard = $ageGroupId');

                              return ProgramPlanCard(ageGroupId: ageGroupId);
                            },
                          ),

                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}



