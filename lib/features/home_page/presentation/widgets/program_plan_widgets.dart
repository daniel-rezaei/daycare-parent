import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:parent_app/features/home_page/presentation/widgets/section_header.dart';
import 'package:parent_app/features/home_page/presentation/widgets/tag_chip.dart';
import 'package:parent_app/features/home_page/presentation/widgets/upcoming_event_widget.dart';

import '../../../../core/network/dio_client.dart';
import '../../../../resorces/pallete.dart';
import '../../data/model/biling_item_model.dart';
import '../../data/repository/learning_plan_repository_impl.dart';
import '../../domain/usecase/get_learning_plan_usecase.dart';
import '../bloc/billing_bloc.dart';
import '../bloc/billing_state.dart';
import '../bloc/learning_plan_bloc.dart';
import '../bloc/learning_plan_event.dart';
import '../bloc/learning_plan_state.dart';
import '../bloc/meal_plan_bloc.dart';
import '../bloc/meal_plan_state.dart';
import 'biling_widget.dart';
import 'meal_card.dart';

String _getMealIcon(String mealType) {
  switch (mealType.toLowerCase()) {
    case 'breakfast':
      return 'assets/images/ic_breakfast.svg';
    case 'lunch':
      return 'assets/images/ic_lunch.svg';
    case 'dinner':
    case 'snack':
      return 'assets/images/ic_snack.svg';
    default:
      return 'assets/images/ic_breakfast.svg';
  }
}

class ProgramPlanCard extends StatefulWidget {
  final String? ageGroupId;
  final VoidCallback? onLoaded;

  const ProgramPlanCard({super.key, required this.ageGroupId, this.onLoaded});

  @override
  State<ProgramPlanCard> createState() => _ProgramPlanCardState();
}

class _ProgramPlanCardState extends State<ProgramPlanCard> {
  late final LearningPlanBloc _learningPlanBloc;

  final List<Color> tagColors = [
    Palette.txtTagForeground,
    Palette.txtTagForeground2,
    Palette.txtTagForeground3,
  ];

  @override
  void initState() {
    super.initState();

    if (widget.ageGroupId != null) {
      _learningPlanBloc = LearningPlanBloc(
        GetLearningPlanUseCase(LearningPlanRepositoryImpl(DioClient())),
      )..add(LoadPlans(ageGroupId: widget.ageGroupId!)); // ← ! برای رفع null
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onLoaded?.call();
    });
  }

  @override
  Widget build(BuildContext context) {
    final billingState = context.watch<BillingBloc>().state;

    if (widget.ageGroupId == null) {
      return const SizedBox(
        height: 200,
        child: Center(child: CircularProgressIndicator()),
      ); // هنوز data نیومده
    }

    return BlocProvider.value(
      value: _learningPlanBloc,
      child: BlocBuilder<LearningPlanBloc, LearningPlanState>(
        builder: (context, state) {
          String leftTitle = '';
          String mainLabel = '';
          List<String> tags = [];
          bool isEmptyPlan = false;

          if (state is LearningPlanLoaded) {
            if (state.categories.isNotEmpty) {
              final firstCategory = state.categories.first;
              leftTitle = firstCategory.title ?? '';
              mainLabel = firstCategory.description ?? '';
              tags = firstCategory.tags
                  .where((tag) => tag.trim().isNotEmpty)
                  .toList();
            } else {
              isEmptyPlan = true;
            }
          } else if (state is LearningPlanLoading) {
            return const SizedBox(
              height: 200,
              child: Center(child: CircularProgressIndicator()),
            );
          } else if (state is LearningPlanError) {
            return const Center(child: Text("Error loading plan"));
          }

          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: const Offset(0, -3),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 16, left: 8, right: 8, bottom: 8),
                    child: Text(
                      "This Week’s Program Plan",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),

                  // 👇 بخش اضافه‌شده برای حالت خالی
                  if (isEmptyPlan)
                     Padding(
                      padding: EdgeInsets.symmetric(vertical: 32),
                      child: Center(
                        child: Column(
                          children: [
                            SvgPicture.asset('assets/images/ic_noplan.svg'),
                            SizedBox(height: 6,),
                            Text(
                              "This week’s plan will appear here soon",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Palette.bgBackground90,
                          borderRadius: const BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                leftTitle,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Palette.borderPrimary,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            SvgPicture.asset('assets/images/ic_plan.svg'),
                                            const SizedBox(width: 6),
                                            Expanded(
                                              child: Text(
                                                mainLabel,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Wrap(
                                          spacing: 8,
                                          runSpacing: 8,
                                          children: tags.asMap().entries.map((entry) {
                                            final index = entry.key;
                                            final tag = entry.value;
                                            return TagChip(
                                              text: tag,
                                              color: tagColors[index % tagColors.length],
                                            );
                                          }).toList(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                  const SizedBox(height: 16),
                  // ----------------- Meal Plan Section -----------------
                  BlocBuilder<MealPlanBloc, MealPlanState>(
                    builder: (context, mealState) {
                      if (mealState is MealPlanLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (mealState is MealPlanLoaded) {
                        final meals = mealState.meals;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
                              child: Text(
                                "Today's Meal",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              height: 165,
                              child: ListView.builder(
                                itemCount: meals.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final meal = meals[index];
                                  final iconPath = _getMealIcon(meal.mealType);
                                  return SizedBox(
                                    width: 130,
                                    child: MealContainer(
                                      title: meal.mealName,
                                      subtitle: meal.mealType,
                                      icon: iconPath,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      } else if (mealState is MealPlanError) {
                        return Center(child: Text('Error: ${mealState.message}'));
                      }
                      return const SizedBox();
                    },
                  ),
                  const SizedBox(height: 16),

                  // ----------------- Upcoming Events -----------------
                  UpcomingEvents(),
                  const SizedBox(height: 12),

                  // ----------------- Billing Section -----------------
                  if (billingState is BillingLoaded && billingState.billings.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: SectionHeader(title: 'Billing'),
                        ),
                        SizedBox(height: 12),
                        BillingCard(),
                      ],
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
