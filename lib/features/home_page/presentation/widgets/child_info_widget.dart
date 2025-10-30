import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../resorces/pallete.dart';
import '../../../child_profile/presentation/screen/child_profile.dart';
import '../bloc/child_bloc.dart';
import '../bloc/child_state.dart';


class ChildInfoWidget extends StatefulWidget {
  final VoidCallback? onLoaded;

  const ChildInfoWidget({super.key, this.onLoaded});

  @override
  State<ChildInfoWidget> createState() => _ChildInfoWidgetState();
}

class _ChildInfoWidgetState extends State<ChildInfoWidget> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onLoaded?.call();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChildBloc, ChildState>(
      builder: (context, state) {
        if (state is ChildLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ChildError) {
          return Center(child: Text('Error: ${state.message}'));
        }

        if (state is ChildLoaded) {
          final child = state.child;

          final firstContact = child.contacts.isNotEmpty
              ? '${child.contacts.first.firstName} ${child.contacts.first.lastName}'
              : 'Unknown';

          final firstClass = child.classes.isNotEmpty ? child.classes.first : null;

          // 🔹 استفاده از آواتار انتخاب‌شده در Bloc
          final photoUrl = state.selectedAvatar ??
              (child.photo != null
                  ? 'http://51.79.53.56:8055/assets/${child.photo}?access_token=1C1ROl_Te_A_sNZNO00O3k32OvRIPcSo'
                  : null);

          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChildProfileWidget(
                    childId: child.id,
                    name: firstContact,
                    dob: child.dob,
                    photoUrl: photoUrl, // 🔹 ارسال آواتار انتخاب‌شده
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 4, bottom: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      firstContact,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Palette.textSecondaryForeground,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.white12,
                              blurRadius: 2,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SvgPicture.asset("assets/images/ic_info.svg"),
                            Text(
                              ' ${firstClass?.roomName ?? '-'} ',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Palette.txtPrimary,
                              ),
                            ),
                            Text(
                              'Age ${formatAge(child.dob)}',
                              style: const TextStyle(
                                fontSize: 11,
                                color: Palette.textMutedForeground,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

// ----------------------------------
// 🔹 تابع محاسبه سن
// ----------------------------------
String formatAge(DateTime? dob) {
  if (dob == null) return '-';

  final now = DateTime.now();

  int years = now.year - dob.year;
  int months = now.month - dob.month;
  int days = now.day - dob.day;

  // اگر روز منفی بود، یک ماه کم می‌کنیم
  if (days < 0) {
    months -= 1;
    days += DateTime(dob.year, dob.month + years * 12 + months + 1, 0).day;
  }

  // اگر ماه منفی بود، یک سال کم می‌کنیم
  if (months < 0) {
    years -= 1;
    months += 12;
  }

  return '${years}y${months}m';
}
