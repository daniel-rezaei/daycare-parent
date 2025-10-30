
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../../../../resorces/pallete.dart';
import '../../../../resorces/style.dart';
import '../../../home_page/domain/entities/event_entity.dart';
import 'date_box_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';



class EventCard extends StatelessWidget {
  final EventEntity model;

  const EventCard({super.key, required this.model});


  List<String> formatDateParts(DateTime? start, DateTime? end) {
    if (start == null) return ['-', '-', '-'];

    final weekday = DateFormat('EEEE').format(start);


    final monthAbbrev = DateFormat('MMM').format(start).toLowerCase();
    final monthDay = '$monthAbbrev${start.day}';


    final startTime = DateFormat('HH:mm').format(start);

    String timePart;
    if (end != null) {
      final endTime = DateFormat('HH:mm').format(end);
      timePart = '$startTime - $endTime';
    } else {
      timePart = startTime;
    }

    return [weekday, monthDay, timePart];
  }

  AssetImage _bgImage(String type) {
    switch (type.toLowerCase()) {
      case 'crafts':
        return const AssetImage('assets/images/background_pink.png');
      case 'trips':
        return const AssetImage('assets/images/back_ground.png');
      default:
        return const AssetImage('assets/images/background_blue.png');
    }
  }

  Color _dateBoxColor(String type) {
    switch (type.toLowerCase()) {
      case 'crafts':
        return Palette.backgroundBgPink;
      case 'trips':
        return Palette.borderPrimary20;
      default:
        return Palette.backgroundBgBlue;
    }
  }


  @override
  Widget build(BuildContext context) {
    final dateParts = formatDateParts(model.startAt, model.endAt);
    final bg = _bgImage(model.eventType ?? '');
    final month = DateFormat.MMM().format(model.startAt ?? DateTime.now()).toUpperCase();
    final day = DateFormat.d().format(model.startAt ?? DateTime.now());
    final dateBoxColor = _dateBoxColor(model.eventType ?? '');

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 14, bottom: 14),
          child: DateBox(
            month: month,
            day: day,
            color: dateBoxColor,
            bgColor: dateBoxColor,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              image: DecorationImage(image: bg, fit: BoxFit.fill),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.03),
                  blurRadius: 6,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.title ?? '',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),

                // 🔹 قسمت زمان (اسکرول افقی)
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 6.0),
                        child: SvgPicture.asset(
                          'assets/images/ic_calendar.svg',
                          width: 14,
                          height: 14,
                        ),
                      ),

                      // ✅ این قسمت حالا اسکرول افقی داره
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              for (int i = 0; i < dateParts.length; i++) ...[
                                Text(
                                  dateParts[i],
                                  style: AppTypography.textTheme.bodySmall?.copyWith(
                                    color: Palette.textSecondaryForeground,
                                  ),
                                ),
                                if (i != dateParts.length - 1)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    child: Container(
                                      width: 1,
                                      height: 16,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 8),
                Text(
                  model.description ?? '',
                  style: const TextStyle(fontSize: 10),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}



