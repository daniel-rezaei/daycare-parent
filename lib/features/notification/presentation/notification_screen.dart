

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:parent_app/features/notification/presentation/widgets/tab_bar_item.dart';

import '../../../resorces/pallete.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Tab> tabs = const [
    Tab(text: "All"),
    Tab(text: "Teachers"),
    Tab(text: "Office"),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget buildNotificationCard({
    required String title,
    required String subtitle,
    required String time,
    String? type,
    String? icon,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
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
          if (icon != null)
            Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Palette.borderPrimary20,
                borderRadius: BorderRadius.circular(16),
              ),
              child: SvgPicture.asset(icon),
            ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16,color: Palette.txtPrimary),
                    ),
                    if (type != null)
                      Container(
                        margin: const EdgeInsets.only(left: 8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Palette.bgColorPink,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          type,
                          style: TextStyle(
                              fontSize: 12,
                              color: Palette.txtTagForeground2,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    Spacer(),
                    Text(
                      time,
                      style:
                      TextStyle(color: Palette.textMutedForeground, fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  subtitle,
                  style: TextStyle(color: Palette.textForeground, fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> getAllNotifications() {
    return [
      buildNotificationCard(
        title: "Sara",
        subtitle: "Sophia’s enjoyed painting today. Look at her masterpleace",
        time: "11:31 AM",
        type: "Teacher",
      ),
      buildNotificationCard(
        title: "daily report",
        subtitle: "Nap Sophia is currently napping peacefully.",
        time: "11:31 AM",
        icon: 'assets/images/calander_notif.svg',
      ),
      buildNotificationCard(
        title: "Today's Daycare Report",
        subtitle:
        "Sophia had a wonderful day at daycare! 🎨 The morning started with creative painting and group play, followed by fun outdoor activities ⚽ full of laughter and energy. Later, your child enjoyed story time 📚 and ended the day with a big smile. You can view the full report along with today’s photos and notes from the teacher in the app 💛.",
        time: "11:31 AM",
        icon: 'assets/images/calander_notif.svg',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE0CBFF), Color(0xFFE9DBFF)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
         Scaffold(
           backgroundColor: Colors.transparent,
           appBar:  AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: IconButton(
    icon: const Icon(Icons.arrow_back, color: Colors.black),
    onPressed: () {},
    ),

    ),
           body:Column(
             children: [
               // این Container جایگزین AppBar دوم می‌شود
               Container(
                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     // عنوان
                     Row(
                       children: [

                         const SizedBox(width: 8),
                         Text(
                           "Notifications",
                           style: TextStyle(
                             color: Colors.black,
                             fontWeight: FontWeight.bold,
                             fontSize: 20,
                           ),
                         ),
                       ],
                     ),
                     const SizedBox(height: 34),
                     // TabBar
                     Container(
                       height: 40,
                       decoration: BoxDecoration(
                         color: Palette.bgColorMute,
                         borderRadius: BorderRadius.circular(10),
                       ),
                       child: Padding(
                         padding: const EdgeInsets.all(4.0),
                         child: TabBar(
                           controller: _tabController,
                           indicatorSize: TabBarIndicatorSize.tab,
                           dividerColor: Colors.transparent,
                           indicator: BoxDecoration(
                             color: Colors.white,
                             borderRadius: BorderRadius.circular(10),
                           ),
                           labelColor: Palette.txtPrimary,
                           unselectedLabelColor: Palette.textMutedForeground,
                           labelStyle: const TextStyle(
                             fontWeight: FontWeight.bold,   // پررنگ
                             fontStyle: FontStyle.normal,   // حتما normal
                             fontSize: 14,
                           ),
                           tabs: [
                             TabItem(title: 'All', count: 6),
                             TabItem(title: 'Teacher', count: 3),
                             TabItem(title: 'Office', count: 1),
                           ],
                         ),
                       ),
                     ),
                   ],
                 ),
               ),
               SizedBox(height: 8,),
               // محتوای تب‌ها
               Expanded(
                 child: Container(
                   decoration:  BoxDecoration(
                     color: Palette.bgColorNotification,
                     borderRadius: BorderRadius.only(
                       topLeft: Radius.circular(24),
                       topRight: Radius.circular(24),
                     ),
                     boxShadow: [
                       BoxShadow(
                         color: Colors.black.withOpacity(0.1), // رنگ سایه
                         spreadRadius: 1, // اندازه سایه
                         blurRadius: 12,   // مقدار تار شدن سایه
                         offset: const Offset(0, -3), // شیفت سایه: y منفی یعنی بالا
                       ),
                     ],
                   ),
                   child: TabBarView(
                     controller: _tabController,
                     children: tabs.map((tab) {
                       return ListView(
                         padding: const EdgeInsets.only(top: 16),
                         children: getAllNotifications(),
                       );
                     }).toList(),
                   ),
                 ),
               ),
             ],
           ),



         )
      ],
    );

  }
}

