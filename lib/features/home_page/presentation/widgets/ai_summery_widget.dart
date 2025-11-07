import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:parent_app/features/home_page/presentation/widgets/section_header.dart';
import '../../../../resorces/pallete.dart';
import '../../../../resorces/style.dart';
import '../../domain/entities/attendance_entity.dart';
import '../bloc/attendance_bloc.dart';
import '../bloc/attendance_state.dart';
import 'check_summery_card_widget.dart';

class AISummaryWidget extends StatelessWidget {
  const AISummaryWidget({super.key});

  // متد امن برای Parse تاریخ
  DateTime? parseDateSafe(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return null;
    try {
      return DateTime.parse(dateStr).toLocal();
    } catch (e) {
      debugPrint('Date parsing error: $e, value: $dateStr');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttendanceChildBloc, AttendanceChildState>(
      builder: (context, state) {
        List<AttendanceChildEntity> attendance = [];
        if (state is AttendanceChildLoaded) {
          attendance = state.attendance;
        }
        debugPrint("🟢 attendance.length = ${attendance.length}");
        for (var a in attendance) {
          debugPrint("➡ checkInAt: ${a.checkInAt}, checkOutAt: ${a.checkOutAt}");
        }

        // 🔹 ۱. جمع‌آوری همه‌ی رویدادها (از تمام رکوردها)
        List<_AttendanceEvent> events = [];
        for (var att in attendance) {
          final checkInTime = parseDateSafe(att.checkInAt);
          final checkOutTime = parseDateSafe(att.checkOutAt);
          if (checkInTime != null) {
            events.add(_AttendanceEvent(type: "Check_In", time: checkInTime));
          }
          if (checkOutTime != null) {
            events.add(_AttendanceEvent(type: "Check_Out", time: checkOutTime));
          }
        }

        // 🔹 ۲. مرتب‌سازی نزولی (جدیدترین اول)
        events.sort((a, b) => b.time.compareTo(a.time));

        // 🔹 ۳. پیدا کردن آخرین رویداد: اول تلاش برای امروز، در صورت نبود تلاش برای Check-Out دیروز، در نهایت آخرین کلی
        final now = DateTime.now();
        _AttendanceEvent? latestEvent;

        // اگر رویدادی در کل وجود دارد
        if (events.isNotEmpty) {
          // رویدادهای امروز
          final todayEvents = events.where((e) =>
          e.time.year == now.year &&
              e.time.month == now.month &&
              e.time.day == now.day).toList();

          if (todayEvents.isNotEmpty) {
            latestEvent = todayEvents.first;
          } else {
            // تلاش برای پیدا کردن آخرین Check-Out دیروز
            final yesterday = now.subtract(const Duration(days: 1));
            final yesterdayCheckOuts = events.where((e) =>
            e.type == "Check_Out" &&
                e.time.year == yesterday.year &&
                e.time.month == yesterday.month &&
                e.time.day == yesterday.day).toList();

            if (yesterdayCheckOuts.isNotEmpty) {
              latestEvent = yesterdayCheckOuts.first;
            } else {
              // اگر نه امروز و نه دیروز، آخرین کلی
              latestEvent = events.first;
            }
          }
        }

        // 🔹 ۴. ساخت Container اصلی — این همیشه نمایش داده می‌شود (تا AI Summary همیشه وجود داشته باشد)
        return Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 6,
                offset: const Offset(0, -2),
              ),
            ],
            image: DecorationImage(
              image: const AssetImage('assets/images/back_ground.png'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.white70.withOpacity(0.45),
                BlendMode.srcATop,
              ),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 16),

              // 🔹 کارت آخرین رویداد (شرطی)
              if (latestEvent != null)
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.white70,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: _buildEventRow(latestEvent),
                  ),
                )
              else
              // 🔹 اگر هیچ رویدادی اصلاً وجود نداشت، پیام مناسب (ولی Container و AI Summary نمایش داده می‌شوند)
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Text(
                    "",
                    style: TextStyle(fontSize: 14),
                  ),
                ),

              // ✅ بخش AI Summary (همیشه نمایش داده شود)
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 16, top: 12),
                child: SectionHeader(title: "AI Summary", onTap: () {}),
              ),
              const Row(children: [Expanded(child: CheckInSummaryCard())]),
            ],
          ),
        );
      },
    );
  }

  // ویجت ساخت ردیف رویداد
  Widget _buildEventRow(_AttendanceEvent event) {
    final eventTime = event.time;
    final timePart = DateFormat('hh:mm').format(eventTime); // ساعت
    final amPmPart = DateFormat('a').format(eventTime); // AM/PM
    final datePart = DateFormat('MMMM d').format(eventTime); // ماه و روز

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SvgPicture.asset('assets/images/ic_check.svg'),
            const SizedBox(width: 8),
            Text(
              '${event.type} at',
              style: AppTypography.textTheme.bodyLarge?.copyWith(
                color: Palette.textMutedForeground,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: timePart,
                    style: AppTypography.textTheme.titleLarge?.copyWith(
                      color: Palette.textSecondaryForeground,
                    ),
                  ),
                  const WidgetSpan(child: SizedBox(width: 4)),
                  TextSpan(
                    text: amPmPart,
                    style: AppTypography.textTheme.bodyLarge?.copyWith(
                      color: Palette.textSecondaryForeground,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 1,
              height: 16,
              color: Colors.grey,
              margin: const EdgeInsets.symmetric(horizontal: 8),
            ),
            Text(
              datePart,
              style: AppTypography.textTheme.bodyLarge?.copyWith(
                color: Palette.textSecondaryForeground,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// کلاس نگهدارنده رویداد
class _AttendanceEvent {
  final String type;
  final DateTime time;

  _AttendanceEvent({required this.type, required this.time});
}

// class AISummaryWidget extends StatelessWidget {
//   const AISummaryWidget({super.key});
//
//   // 🔹 Parse امن برای جلوگیری از FormatException
//   DateTime? parseDateSafe(String? dateStr) {
//     if (dateStr == null || dateStr.isEmpty) return null;
//     try {
//       return DateTime.parse(dateStr).toLocal();
//     } catch (e) {
//       debugPrint('Date parsing error: $e, value: $dateStr');
//       return null;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AttendanceChildBloc, AttendanceChildState>(
//       builder: (context, state) {
//         List<AttendanceChildEntity> attendance = [];
//         if (state is AttendanceChildLoaded) {
//           attendance = state.attendance;
//         }
//
//         return Container(
//           decoration: BoxDecoration(
//             borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(24),
//               topRight: Radius.circular(24),
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.08),
//                 blurRadius: 6,
//                 offset: const Offset(0, -2),
//               ),
//             ],
//             image: DecorationImage(
//               image: const AssetImage('assets/images/back_ground.png'),
//               fit: BoxFit.cover,
//               colorFilter: ColorFilter.mode(
//                 Colors.white70.withOpacity(0.45),
//                 BlendMode.srcATop,
//               ),
//             ),
//           ),
//           child: Column(
//             children: [
//               const SizedBox(height: 16),
//
//               ...attendance.map((att) {
//                 final hasCheckIn = att.checkInAt != null && att.checkInAt!.isNotEmpty;
//                 final hasCheckOut = att.checkOutAt != null && att.checkOutAt!.isNotEmpty;
//
//                 if (!hasCheckIn && !hasCheckOut) return const SizedBox.shrink();
//
//                 // 🔹 انتخاب آخرین رویداد
//                 String eventTimeStr;
//                 if (hasCheckIn && hasCheckOut) {
//                   final checkInTime = parseDateSafe(att.checkInAt!)!;
//                   final checkOutTime = parseDateSafe(att.checkOutAt!)!;
//                   eventTimeStr = checkInTime.isAfter(checkOutTime) ? att.checkInAt! : att.checkOutAt!;
//                 } else {
//                   eventTimeStr = hasCheckIn ? att.checkInAt! : att.checkOutAt!;
//                 }
//
//                 final eventType = (eventTimeStr == att.checkInAt) ? "Check_In" : "Check_Out";
//
//                 final eventTime = parseDateSafe(eventTimeStr);
//                 if (eventTime == null) return const SizedBox.shrink();
//
//                 final timePart = DateFormat('hh:mm').format(eventTime);
//                 final amPmPart = DateFormat('a').format(eventTime);
//                 final datePart = DateFormat('MMMM d').format(eventTime);
//
//                 return Padding(
//                   padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(16),
//                       boxShadow: const [
//                         BoxShadow(
//                           color: Colors.white70,
//                           blurRadius: 6,
//                           offset: Offset(0, 2),
//                         ),
//                       ],
//                     ),
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                             SvgPicture.asset('assets/images/ic_check.svg'),
//                             const SizedBox(width: 8),
//                             Text(
//                               '$eventType at',
//                               style: AppTypography.textTheme.bodyLarge?.copyWith(
//                                 color: Palette.textMutedForeground,
//                               ),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             Text.rich(
//                               TextSpan(
//                                 children: [
//                                   TextSpan(
//                                     text: timePart,
//                                     style: AppTypography.textTheme.titleLarge?.copyWith(
//                                       color: Palette.textSecondaryForeground,
//                                     ),
//                                   ),
//                                   const WidgetSpan(child: SizedBox(width: 4)),
//                                   TextSpan(
//                                     text: amPmPart,
//                                     style: AppTypography.textTheme.bodyLarge?.copyWith(
//                                       color: Palette.textSecondaryForeground,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               width: 1,
//                               height: 16,
//                               color: Colors.grey,
//                               margin: const EdgeInsets.symmetric(horizontal: 8),
//                             ),
//                             Text(
//                               datePart,
//                               style: AppTypography.textTheme.bodyLarge?.copyWith(
//                                 color: Palette.textSecondaryForeground,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               }),
//
//               // ✅ AI Summary Section
//               Padding(
//                 padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 16, top: 12),
//                 child: SectionHeader(title: "AI Summary", onTap: () {}),
//               ),
//               const Row(children: [Expanded(child: CheckInSummaryCard())]),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }


