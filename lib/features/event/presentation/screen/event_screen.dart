import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parent_app/features/home_page/domain/entities/event_entity.dart';
import '../../../home_page/presentation/bloc/event_bloc.dart';
import '../../../home_page/presentation/bloc/event_state.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/event_card_widget.dart';
import '../widgets/season_selector_widget.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  late Season selectedSeason;
  String selectedYear = DateTime.now().year.toString();

  @override
  void initState() {
    super.initState();

    final month = DateTime.now().month;

    if ([3, 4, 5].contains(month)) {
      selectedSeason = Season.spring;
    } else if ([6, 7, 8].contains(month)) {
      selectedSeason = Season.summer;
    } else if ([9, 10, 11].contains(month)) {
      selectedSeason = Season.fall;
    } else {
      selectedSeason = Season.winter;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // پس‌زمینه
          Positioned.fill(
            child: Image.asset(
              'assets/images/back_gry.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.05)),
          ),
          SafeArea(
            child: Column(
              children: [
                // Custom AppBar با انتخاب سال
                CustomAppBar(
                  onSeasonChanged: (String year) {
                    setState(() {
                      selectedYear = year;
                    });
                  },
                ),

                const SizedBox(height: 8),

                // انتخاب فصل
                SeasonSelector(
                  selected: selectedSeason,
                  onSelect: (season) => setState(() => selectedSeason = season), selectedYear: selectedYear,
                ),

                const SizedBox(height: 12),

                // لیست EventCardها داخل Container سفید
                Expanded(
                  child: BlocBuilder<EventBloc, EventState>(
                    builder: (context, state) {
                      if (state is EventLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is EventError) {
                        return Center(child: Text('Error: ${state.message}'));
                      } else if (state is EventLoaded) {
                        // فیلتر بر اساس فصل و سال
                        final filteredEvents = _filterBySeasonAndYear(
                          state.events,
                          selectedSeason,
                          selectedYear,
                        );

                        // مرتب‌سازی بر اساس تاریخ
                        final sortedEvents = List<EventEntity>.from(filteredEvents)
                          ..sort((a, b) => (a.startAt ?? DateTime.now())
                              .compareTo(b.startAt ?? DateTime.now()));

                        if (sortedEvents.isEmpty) {
                          return Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 6,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: Text('No events this season.'),
                              ),
                            ),
                          );
                        }

                        return Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ListView.separated(
                            padding: const EdgeInsets.all(16),
                            itemCount: sortedEvents.length,
                            separatorBuilder: (_, __) => const SizedBox(height: 12),
                            itemBuilder: (context, i) =>
                                EventCard(model: sortedEvents[i]),
                          ),
                        );
                      }

                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<EventEntity> _filterBySeasonAndYear(
      List<EventEntity> events, Season season, String year) {
    return events.where((e) {
      final start = e.startAt;
      if (start == null) return false;

      // فیلتر فصل
      final month = start.month;
      bool seasonMatch = false;
      switch (season) {
        case Season.spring:
          seasonMatch = [3, 4, 5].contains(month);
          break;
        case Season.summer:
          seasonMatch = [6, 7, 8].contains(month);
          break;
        case Season.fall:
          seasonMatch = [9, 10, 11].contains(month);
          break;
        case Season.winter:
          seasonMatch = [12, 1, 2].contains(month);
          break;
      }

      // فیلتر سال
      final yearMatch = start.year.toString() == year;

      return seasonMatch && yearMatch;
    }).toList();
  }
}
