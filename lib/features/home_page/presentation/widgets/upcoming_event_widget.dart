import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:parent_app/core/network/dio_client.dart';
import '../../../event/presentation/screen/event_screen.dart';
import '../../data/repository/event_repository_impl.dart';
import '../../domain/usecase/get_event_usecase.dart';
import '../bloc/event_bloc.dart';
import '../bloc/event_event.dart';
import '../bloc/event_state.dart';
import '../../../home_page/presentation/widgets/section_header.dart';



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
    final eventRepository = EventRepositoryImpl(DioClient());

    return Padding(
      padding: const EdgeInsets.only(top: 32, left: 8, right: 8, bottom: 8),
      child: BlocBuilder<EventBloc, EventState>(
        builder: (context, state) {
          if (state is EventLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is EventError) {
            return Center(child: Text("Error: ${state.message}"));
          } else if (state is EventLoaded) {
            final today = DateTime.now();
            final endOfYear = DateTime(today.year, 12, 31, 23, 59, 59);

            final upcomingEvents = state.events.where((event) {
              final eventDate = event.startAt;
              return eventDate != null &&
                  eventDate.isAfter(today.subtract(const Duration(days: 1))) &&
                  eventDate.isBefore(endOfYear.add(const Duration(seconds: 1)));
            }).toList();

            // 👇 اگر لیست خالی بود، کل سکشن رو نشون نده
            if (upcomingEvents.isEmpty) {
              return const SizedBox.shrink();
            }

            final selectedEvent = upcomingEvents[selectedIndex];
            final dateParts = formatDateParts(selectedEvent.startAt ?? DateTime.now());

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ✅ Section Header
                SectionHeader(
                  title: "Upcoming Events",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider(
                          create: (_) =>
                          EventBloc(GetEventUseCase(eventRepository))..add(LoadEvents()),
                          child: const EventPage(),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),

                // 👇 کد اصلی کارت‌ها (بدون تغییر)
                SizedBox(
                  height: 130,
                  child: Row(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(upcomingEvents.length, (index) {
                            final event = upcomingEvents[index];
                            final isSelected = index == selectedIndex;

                            return Transform.translate(
                              offset: Offset(index == 0 ? 0 : -8, 0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() => selectedIndex = index);
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  width: 40,
                                  height: 95,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFEFEEF0),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      bottomLeft: Radius.circular(16),
                                    ),
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
                      Expanded(
                        child: Transform.translate(
                          offset: const Offset(-10, 0),
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
                                image: const DecorationImage(
                                  image: AssetImage("assets/images/background_upcoming.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    selectedEvent.title ?? "-",
                                    maxLines: 1,
                                    softWrap: false,
                                    overflow: TextOverflow.clip,
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
                                        SvgPicture.asset(
                                          'assets/images/ic_calendar.svg',
                                          width: 16,
                                          height: 16,
                                        ),
                                        const SizedBox(width: 6),
                                        Expanded(
                                          child: ClipRect(
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              physics: const NeverScrollableScrollPhysics(),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children:
                                                List.generate(dateParts.length, (i) {
                                                  return Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        dateParts[i],
                                                        maxLines: 1,
                                                        softWrap: false,
                                                        overflow: TextOverflow.clip,
                                                        style: const TextStyle(
                                                          fontSize: 11,
                                                          color: Colors.black87,
                                                        ),
                                                      ),
                                                      if (i != dateParts.length - 1)
                                                        Container(
                                                          width: 1,
                                                          height: 16,
                                                          color: Colors.grey[400],
                                                          margin:
                                                          const EdgeInsets.symmetric(
                                                              horizontal: 6),
                                                        ),
                                                    ],
                                                  );
                                                }),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

}



