import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../login/domain/entity/user_entity.dart';
import '../../../message/presentation/screen/message_screen.dart';
import '../../../message/presentation/screen/parent_message_screen.dart';
import '../../../notification/presentation/notification_screen.dart';
import '../../../resource_home/parent/resource_screen.dart';
import '../bloc/bottom_nav_bloc.dart';
import '../bloc/bottom_nav_state.dart';
import '../bloc/child_bloc.dart';
import '../bloc/child_state.dart';
import 'bottom_navigation.dart';
import 'home_page.dart';

class HomeScreen extends StatelessWidget {
  final UserEntity user;

  const HomeScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChildBloc, ChildState>(
      builder: (context, childState) {
        String? activeChildId;

        // if (childState is ChildLoaded) {
        //   activeChildId = childState.child.id;
        // }
        if (childState is ChildSelected) {
          activeChildId = childState.child.id;
        } else if (childState is ChildListLoaded) {
          activeChildId = childState.selectedChild.id;
        }

        final pages = [
          HomePage(user: user),
          if (activeChildId != null)
            ParentMessageScreen(activeChildId: activeChildId)
          else
            const Center(child: CircularProgressIndicator()),
          const Center(child: Text("Magic Page")),
          NotificationsScreen(),
          if (activeChildId != null)
            ResourceScreen(activeChildId: activeChildId)
          else
            const Center(child: CircularProgressIndicator()),
        ];

        return BlocBuilder<BottomNavBloc, BottomNavState>(
          builder: (context, navState) {
            return SafeArea(
              child: Scaffold(
                body: IndexedStack(
                  index: navState.selectedIndex,
                  children: pages,
                ),
                bottomNavigationBar:  CustomBottomNav(),
              ),
            );
          },
        );
      },
    );
  }
}
