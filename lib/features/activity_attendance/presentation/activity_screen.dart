import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:parent_app/features/activity_attendance/presentation/widgets/date_selector.dart';
import '../../../../resorces/pallete.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({
    super.key,
    this.childId,
    this.name,
    this.dob,
    this.photoUrl,
  });

  final String? name;
  final DateTime? dob;
  final String? photoUrl;
  final String? childId;

  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  @override
  void initState() {
    super.initState();
    _fetchChildData();
  }

  void _fetchChildData() {
    final id = widget.childId ?? "";
  }

  String formatDate(DateTime? date) {
    if (date == null) return '-';
    return DateFormat('MMMM d, yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE0CBFF), Color(0xFFE9DAFF)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_sharp, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text(
              "Activity & Attendance",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            centerTitle: false,
          ),
          body: Column(
            children: [
              // -----------------------
              // Child Header
              // -----------------------
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage:
                      (widget.photoUrl != null && widget.photoUrl!.isNotEmpty)
                          ? (widget.photoUrl!.startsWith('http')
                          ? CachedNetworkImageProvider(widget.photoUrl!)
                          : AssetImage(widget.photoUrl!) as ImageProvider)
                          : null,
                      child: (widget.photoUrl == null || widget.photoUrl!.isEmpty)
                          ? const Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.grey,
                      )
                          : null,
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name ?? '',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Palette.bgBackground90,
                            border: Border.all(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset('assets/images/ic_gifts.svg'),
                              const SizedBox(width: 6),
                              const Text(
                                'Date of Birth',
                                style: TextStyle(fontSize: 13),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                width: 1,
                                height: 18,
                                color: Palette.bgColorDivider,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                formatDate(widget.dob),
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Palette.txtPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ----------------------- بخش بالای صفحه -----------------------
              Container(
                decoration: BoxDecoration(
                  color: Palette.backMood,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DateSelector(),
                      const SizedBox(height: 16),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 14),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(22),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //----------------------------------------------------------------
                            //                     CHECK-IN / OUT ROW
                            //----------------------------------------------------------------
                            Row(
                              children: [
                                // ---------------- LEFT SIDE (Check In) ----------------
                                Expanded(
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/images/ic_check.svg',
                                      ),
                                      const SizedBox(width: 4),
                                      const Text(
                                        "Check_In",
                                        style: TextStyle(
                                          color: Palette.textSecondaryForeground,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: "08:00 ",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Palette.textForeground,
                                              ),
                                            ),
                                            TextSpan(
                                              text: "AM",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: Palette.textForeground,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // ---------------- RIGHT SIDE (Check Out) ----------------
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/images/ic_checkout.svg',
                                      ),
                                      const SizedBox(width: 5),
                                      const Text(
                                        "Check_Out",
                                        style: TextStyle(
                                          color: Palette.textSecondaryForeground,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: "12:00 ",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Palette.textForeground,
                                              ),
                                            ),
                                            TextSpan(
                                              text: "AM",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: Palette.textForeground,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 16),

                            // -----------------------------------------
                            // SEPARATOR LINE
                            // -----------------------------------------
                            Container(
                              height: 1,
                              width: double.infinity,
                              color: Colors.grey.shade300,
                            ),

                            const SizedBox(height: 16),

                            //----------------------------------------------------------------
                            //                     AUTHORIZED ROW
                            //----------------------------------------------------------------
                            Row(
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/ic_auth.svg',
                                    ),
                                    const SizedBox(width: 6),
                                    const Text(
                                      "Authorized",
                                      style: TextStyle(
                                        color: Palette.textSecondaryForeground,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                const Text(
                                  "Jane Doe",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Palette.textForeground,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 36),
                    ],
                  ),
                ),
              ),

              // ----------------------- بخش پایین صفحه Activity -----------------------
              Expanded(
                child: Transform.translate(
                  offset: const Offset(0, -20),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Palette.bgColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: ListView(
                      padding: const EdgeInsets.all(12),
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            'Activity',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Palette.textForeground,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 12,
                          ),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 12),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Palette.borderPrimary20,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: SvgPicture.asset(
                                  'assets/images/calander_notif.svg',
                                ),
                              ),
                              // متن اصلی
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          fit: FlexFit.loose,
                                          child: Text(
                                            'daily report',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Palette.txtPrimary,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          '11:31 AM',
                                          style: TextStyle(
                                            color: Palette.textMutedForeground,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Meal Breakfast ( Oatmeal & Fruit ) Ate well',
                                      style: TextStyle(
                                        color: Palette.textForeground,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
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
            ],
          ),
        ),
      ],
    );
  }
}
