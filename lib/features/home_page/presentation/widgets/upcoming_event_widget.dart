// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:intl/intl.dart';
// import 'package:parent_app/core/network/dio_client.dart';
// import '../../../../resorces/pallete.dart';
// import '../../../../resorces/style.dart';
// import '../../../event/presentation/screen/event_screen.dart';
// import '../../data/repository/event_repository_impl.dart';
// import '../../domain/entities/event_entity.dart';
// import '../../domain/usecase/get_event_usecase.dart';
// import '../bloc/event_bloc.dart';
// import '../bloc/event_event.dart';
// import '../bloc/event_state.dart';
// import '../../../home_page/presentation/widgets/section_header.dart';
//
// class UpcomingEvents extends StatelessWidget {
//   const UpcomingEvents({super.key});
//
//   String formatShortDate(DateTime? date) {
//     if (date == null) return "-";
//     return DateFormat('d MMM').format(date);
//   }
//
//   List<String> formatDateParts(DateTime date) {
//     final weekday = DateFormat('EEEE').format(date);
//     final monthDay = DateFormat('MMM d').format(date);
//     final time = DateFormat('hh:mm a').format(date);
//     return [weekday, monthDay, time];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final eventRepository = EventRepositoryImpl(DioClient());
//
//     return Padding(
//       padding: const EdgeInsets.only(top: 32, left: 8, right: 8, bottom: 8),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SectionHeader(
//             title: "Upcoming Events",
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => BlocProvider(
//                     create: (_) => EventBloc(GetEventUseCase(eventRepository))
//                       ..add(LoadEvents()),
//                     child: const EventPage(),
//                   ),
//                 ),
//               );
//             },
//           ),
//           const SizedBox(height: 20),
//
//           // BlocBuilder داخلی
//           BlocProvider(
//             create: (_) => EventBloc(GetEventUseCase(eventRepository))..add(LoadEvents()),
//             child: BlocBuilder<EventBloc, EventState>(
//               builder: (context, state) {
//                 if (state is EventLoading) {
//                   return const SizedBox(
//                     height: 140,
//                     child: Center(child: CircularProgressIndicator()),
//                   );
//                 } else if (state is EventLoaded) {
//                   final now = DateTime.now();
//                   int currentQuarter = ((now.month - 1) ~/ 3) + 1;
//                   int startMonth = (currentQuarter - 1) * 3 + 1;
//                   int endMonth = startMonth + 2;
//                   final endOfQuarter = DateTime(now.year, endMonth + 1, 0);
//
//                   final filteredEvents = state.events.where((event) {
//                     final start = event.startAt ?? now;
//                     return start.isAfter(now) && start.isBefore(endOfQuarter);
//                   }).toList();
//
//                   if (filteredEvents.isEmpty) {
//                     return const SizedBox(
//                       height: 140,
//                       child: Center(child: Text("No upcoming events")),
//                     );
//                   }
//
//                   final limitedEvents = filteredEvents.take(5).toList();
//
//                   // 👇 کارت‌ها روی هم و انتخاب با کلیک روی تاریخ
//                   return StatefulBuilder(
//                     builder: (context, setState) {
//                       int selectedIndex = 0;
//                       return SizedBox(
//                         height: 140,
//                         child: Stack(
//                           clipBehavior: Clip.none,
//                           children: List.generate(limitedEvents.length, (index) {
//                             final event = limitedEvents[index];
//                             final isSelected = index == selectedIndex;
//
//                             return AnimatedPositioned(
//                               duration: const Duration(milliseconds: 400),
//                               curve: Curves.easeInOut,
//                               left: isSelected ? 0 : index * 25.0,
//                               top: isSelected ? 0 : index * 15.0,
//                               child: AnimatedScale(
//                                 duration: const Duration(milliseconds: 300),
//                                 scale: isSelected ? 1.0 : 0.9,
//                                 child: AnimatedOpacity(
//                                   duration: const Duration(milliseconds: 300),
//                                   opacity: isSelected ? 1 : 0.7,
//                                   child: IgnorePointer(
//                                     ignoring: !isSelected,
//                                     child: Stack(
//                                       children: [
//                                         _buildEventCard(event),
//                                         Positioned(
//                                           left: 0,
//                                           top: 0,
//                                           bottom: 0,
//                                           width: 60,
//                                           child: GestureDetector(
//                                             behavior: HitTestBehavior.translucent,
//                                             onTap: () {
//                                               setState(() {
//                                                 selectedIndex = index;
//                                               });
//                                             },
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             );
//                           }).reversed.toList(),
//                         ),
//                       );
//                     },
//                   );
//                 } else if (state is EventError) {
//                   return SizedBox(
//                     height: 140,
//                     child: Center(child: Text("Error: ${state.message}")),
//                   );
//                 } else {
//                   return const SizedBox.shrink();
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildEventCard(EventEntity event) {
//     final dateParts = formatDateParts(event.startAt ?? DateTime.now());
//
//     return Container(
//       width: 300,
//       height: 120,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: const [
//           BoxShadow(
//             color: Colors.black26,
//             blurRadius: 6,
//             offset: Offset(0, 3),
//           ),
//         ],
//         image: const DecorationImage(
//           image: AssetImage("assets/images/background_upcoming.png"),
//           fit: BoxFit.cover,
//         ),
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // تاریخ عمودی سمت چپ
//           Container(
//             width: 48,
//             height: double.infinity,
//             decoration: const BoxDecoration(
//               color: Palette.bgBackground80,
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(16),
//                 bottomLeft: Radius.circular(16),
//               ),
//             ),
//             alignment: Alignment.center,
//             child: RotatedBox(
//               quarterTurns: -1,
//               child: Text(
//                 formatShortDate(event.startAt),
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//           ),
//
//           // جزئیات کارت
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     event.title ?? "-",
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: AppTypography.textTheme.titleLarge?.copyWith(
//                       color: Palette.textSecondaryForeground,
//                     ),
//                   ),
//                   Container(
//                     padding: const EdgeInsets.all(6),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Row(
//                       children: [
//                         SvgPicture.asset(
//                           'assets/images/ic_calendar.svg',
//                           width: 16,
//                           height: 16,
//                         ),
//                         const SizedBox(width: 6),
//                         ...List.generate(dateParts.length, (index) {
//                           return Row(
//                             children: [
//                               Text(
//                                 dateParts[index],
//                                 style: AppTypography.textTheme.bodyLarge
//                                     ?.copyWith(
//                                   color: Palette.textSecondaryForeground,
//                                 ),
//                               ),
//                               if (index != dateParts.length - 1)
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(horizontal: 6),
//                                   child: Container(
//                                     width: 1,
//                                     height: 16,
//                                     color: Colors.grey[400],
//                                   ),
//                                 ),
//                             ],
//                           );
//                         }),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/event_bloc.dart';
import '../bloc/event_state.dart';

class UpcomingEventsCardStack extends StatefulWidget {
  const UpcomingEventsCardStack({super.key});

  @override
  State<UpcomingEventsCardStack> createState() => _UpcomingEventsCardStackState();
}

class _UpcomingEventsCardStackState extends State<UpcomingEventsCardStack> {
  int selectedIndex = 0;

  String formatShortDate(DateTime? date) {
    if (date == null) return "-";
    return DateFormat('d MMM').format(date);
  }

  List<String> formatDateParts(DateTime date) {
    final weekday = DateFormat('EEEE').format(date);
    final monthDay = DateFormat('MMMM d').format(date);
    final time = DateFormat('hh:mm a').format(date);
    return [weekday, monthDay, time];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventBloc, EventState>(
      builder: (context, state) {
        if (state is EventLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is EventError) {
          return Center(child: Text("Error: ${state.message}"));
        } else if (state is EventLoaded) {
          final events = state.events;
          if (events.isEmpty) {
            return const Center(child: Text("No upcoming events"));
          }

          final selectedEvent = events[selectedIndex];
          final dateParts = formatDateParts(selectedEvent.startAt ?? DateTime.now());

          return Container(
            height: 130,
            child: Row(
              children: [
                // 🔹 تاریخ‌ها (به‌صورت عمودی ولی در ردیف افقی کنار هم)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(events.length, (index) {
                      final event = events[index];
                      final isSelected = index == selectedIndex;

                      return GestureDetector(
                        onTap: () {
                          setState(() => selectedIndex = index);
                        },
                        child: Transform.translate(
                          offset: Offset(index == events.length - 1 ? 0 : -16, 0),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.only(right: 0), // بدون مقدار منفی
                            width: 60,
                            height: 90,
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.white : const Color(0xFFF5F5F5),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                bottomLeft: Radius.circular(16),
                              ),
                              boxShadow: isSelected
                                  ? [
                                const BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 6,
                                  offset: Offset(0, 3),
                                )
                              ]
                                  : [],
                            ),
                            alignment: Alignment.center,
                            child: RotatedBox(
                              quarterTurns: -1,
                              child: Text(
                                formatShortDate(event.startAt),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isSelected ? Colors.black : Colors.grey[700],
                                ),
                              ),
                            ),
                          ),
                        ),

                      );
                    }),
                  ),
                ),

                const SizedBox(width: 8),

                // 🔹 کارت آبی سمت راست (نمایش اطلاعات ایونت انتخاب‌شده)
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    transitionBuilder: (child, animation) => FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0.2, 0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      ),
                    ),
                    child: Container(
                      key: ValueKey(selectedEvent.id),
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFD6EFFF),
                            Color(0xFFAEE1FF),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            selectedEvent.title ?? "-",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.calendar_today, size: 16, color: Colors.blueAccent),
                                const SizedBox(width: 6),
                                ...List.generate(dateParts.length, (i) {
                                  return Row(
                                    children: [
                                      Text(
                                        dateParts[i],
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      if (i != dateParts.length - 1)
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 6),
                                          child: Container(
                                            width: 1,
                                            height: 16,
                                            color: Colors.grey[400],
                                          ),
                                        ),
                                    ],
                                  );
                                }),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}


