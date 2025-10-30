
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:parent_app/core/network/dio_client.dart';
import 'package:parent_app/features/home_page/domain/repositories/event_repository.dart';
import 'package:parent_app/features/home_page/presentation/widgets/section_header.dart';
import '../../../../resorces/pallete.dart';
import '../../../../resorces/style.dart';
import '../../../event/presentation/screen/event_screen.dart';
import '../../data/repository/event_repository_impl.dart';
import '../../domain/entities/event_entity.dart';
import '../../domain/usecase/get_event_usecase.dart';
import '../bloc/event_bloc.dart';
import '../bloc/event_event.dart';
import '../bloc/event_state.dart';

class UpcomingEvents extends StatelessWidget {
  const UpcomingEvents({super.key});

  String formatDate(DateTime? date) {
    if (date == null) return "-";
    return DateFormat('EEEE MMMM d  hh:mm a').format(date);
  }

  String formatShortDate(DateTime? date) {
    if (date == null) return "-";
    return DateFormat('d MMM').format(date);
  }
  List<String> formatDateParts(DateTime date) {
    final weekday = DateFormat('EEEE').format(date);      // Monday
    final monthDay = DateFormat('MMM d').format(date);    // Jul 16
    final time = DateFormat('hh:mm a').format(date);      // 12:00 AM
    return [weekday, monthDay, time];
  }

  @override
  Widget build(BuildContext context) {
    final eventRepository = EventRepositoryImpl(DioClient());
    return Padding(
      padding: const EdgeInsets.only(top: 32,left: 8,right: 8,bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(title: "Upcoming Events", onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider(
                  create: (_) => EventBloc(GetEventUseCase(eventRepository))..add(LoadEvents()),
                  child: const EventPage(),
                ),
              ),
            );
          }),

          const SizedBox(height: 20),

          BlocBuilder<EventBloc, EventState>(
            builder: (context, state) {
              if (state is EventLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is EventLoaded) {
                final events = state.events;

                if (events.isEmpty) {
                  return const Text("No upcoming events.");
                }

                final event = events.first;

                return _buildEventCard(event);
              } else if (state is EventError) {
                return Text("Error: ${state.message}");
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(EventEntity event) {
    final dateParts = formatDateParts(event.startAt ?? DateTime.now());
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 60,
          height: 100,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 36,
                height: 100,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Palette.bgBackground80,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: RotatedBox(
                  quarterTurns: -1,
                  child: Text(
                    formatShortDate(event.startAt),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              Positioned(
                left: 30,
                child: Container(
                  width: 36,
                  height: 100,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Palette.bgBackground80,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: RotatedBox(
                    quarterTurns: -1,
                    child: Text(
                      formatShortDate(event.endAt),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),


        Expanded(
          child: Container(
            height: 100,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
              image: const DecorationImage(
                image: AssetImage("assets/images/background_upcoming.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title ?? "-",
                  style: AppTypography.textTheme.titleLarge?.copyWith(
                    color: Palette.textSecondaryForeground,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                  ),

                  child:
                  Row(
                    children: [
                      SvgPicture.asset('assets/images/ic_calendar.svg'),
                      const SizedBox(width: 6),

                      ...List.generate(dateParts.length, (index) {
                        return Row(
                          children: [
                            Text(
                              dateParts[index],
                              style: AppTypography.textTheme.bodyLarge?.copyWith(
                                color: Palette.textSecondaryForeground,
                              ),
                            ),
                            if (index != dateParts.length - 1)
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
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
      ],
    );
  }
}

