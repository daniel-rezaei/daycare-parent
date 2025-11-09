
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
          // تصویر پس‌زمینه
          Positioned.fill(
            child: Image.asset(
              'assets/images/back_gry.png',
              fit: BoxFit.cover,
            ),
          ),

          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.05),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                CustomAppBar(
                  onSeasonChanged: (String season) {
                    setState(() {
                      switch (season) {
                        case 'Spr':
                          selectedSeason = Season.spring;
                          break;
                        case 'Sum':
                          selectedSeason = Season.summer;
                          break;
                        case 'Fall':
                          selectedSeason = Season.fall;
                          break;
                        case 'Win':
                          selectedSeason = Season.winter;
                          break;
                      }
                    });
                  },
                ),

                const SizedBox(height: 8),

                SeasonSelector(
                  selected: selectedSeason,
                  onSelect: (season) => setState(() => selectedSeason = season),
                ),

                const SizedBox(height: 12),

                // لیست EventCardها داخل کانتینر سفید
                Expanded(
                  child: BlocBuilder<EventBloc, EventState>(
                    builder: (context, state) {
                      if (state is EventLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is EventError) {
                        return Center(child: Text('Error: ${state.message}'));
                      } else if (state is EventLoaded) {
                        final events = _filterBySeason(state.events, selectedSeason);

                        if (events.isEmpty) {
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
                            itemCount: events.length,
                            separatorBuilder: (_, __) => const SizedBox(height: 12),
                            itemBuilder: (context, i) => EventCard(model: events[i]),
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

  List<EventEntity> _filterBySeason(List<EventEntity> events, Season s) {
    return events.where((e) {
      final m = e.startAt?.month;
      switch (s) {
        case Season.spring:
          return [3, 4, 5].contains(m);
        case Season.summer:
          return [6, 7, 8].contains(m);
        case Season.fall:
          return [9, 10, 11].contains(m);
        case Season.winter:
          return [12, 1, 2].contains(m);
      }
    }).toList();
  }
}


