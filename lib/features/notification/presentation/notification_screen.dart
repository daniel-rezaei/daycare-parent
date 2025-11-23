import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:parent_app/features/notification/presentation/widgets/tab_bar_item.dart';
import '../../../resorces/pallete.dart';
import 'bloc/notification_bloc.dart';
import 'bloc/notification_event.dart';
import 'bloc/notification_state.dart';

class NotificationsScreen extends StatefulWidget {
  final String? activeChildId;
  const NotificationsScreen({super.key, this.activeChildId});

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _notificationsLoaded = false;

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
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_notificationsLoaded && widget.activeChildId != null) {
      context.read<NotificationBloc>().add(
        LoadNotificationsEvent(widget.activeChildId!),
      );
      _notificationsLoaded = true;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // فرمت ساعت 24 ساعته + AM/PM
  String formatTime(DateTime dt) {
    String hour = dt.hour.toString().padLeft(2, '0');
    String minute = dt.minute.toString().padLeft(2, '0');
    String ampm = dt.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $ampm';
  }

  Widget buildNotificationCard({
    required String title,
    required String subtitle,
    required DateTime? createdAt,
    String? type,
    String? icon,
  }) {
    String timeText = createdAt != null ? formatTime(createdAt) : "";

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
          // آیکن ثابت
          if (icon != null)
            Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Palette.borderPrimary20,
                borderRadius: BorderRadius.circular(16),
              ),
              child: SvgPicture.asset('assets/images/calander_notif.svg'),
            ),
          // متن اصلی
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      fit: FlexFit.loose,
                      child: Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Palette.txtPrimary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (type != null)
                      Container(
                        margin: const EdgeInsets.only(left: 8),
                        padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Palette.bgColorPink,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          type,
                          style: TextStyle(
                            fontSize: 12,
                            color: Palette.txtTagForeground2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    const SizedBox(width: 8),
                    Text(
                      timeText,
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
                  subtitle,
                  style: TextStyle(
                      color: Palette.textForeground,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildNotificationList(List notifications, String? filterRole) {
    final filtered = filterRole == null
        ? notifications
        : notifications
        .where((n) => n.senderRole?.toLowerCase() == filterRole.toLowerCase())
        .toList();

    return filtered
        .map((n) => buildNotificationCard(
      title: n.title ?? n.senderRole ?? "Notification",
      subtitle: n.description ?? "",
      createdAt: n.createdAt,
      type: n.senderRole,
      icon: 'assets/images/calander_notif.svg', // آیکن ثابت
    ))
        .toList();
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
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {},
            ),
          ),
          body: Column(
            children: [
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        SizedBox(width: 8),
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
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                          ),
                          tabs: const [
                            TabItem(title: 'All'),
                            TabItem(title: 'Teacher'),
                            TabItem(title: 'Office'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Palette.bgColorNotification,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 12,
                        offset: const Offset(0, -3),
                      ),
                    ],
                  ),
                  child: BlocBuilder<NotificationBloc, NotificationState>(
                    builder: (context, state) {
                      if (state is NotificationLoading) {
                        return const Center(
                            child: CircularProgressIndicator());
                      } else if (state is NotificationError) {
                        return Center(child: Text(state.message));
                      } else if (state is NotificationLoaded) {
                        return TabBarView(
                          controller: _tabController,
                          children: [
                            ListView(
                              padding: const EdgeInsets.only(top: 16),
                              children:
                              buildNotificationList(state.notifications, null),
                            ),
                            ListView(
                              padding: const EdgeInsets.only(top: 16),
                              children: buildNotificationList(
                                  state.notifications, "teacher"),
                            ),
                            ListView(
                              padding: const EdgeInsets.only(top: 16),
                              children: buildNotificationList(
                                  state.notifications, "office"),
                            ),
                          ],
                        );
                      }
                      return const SizedBox.shrink();
                    },
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
