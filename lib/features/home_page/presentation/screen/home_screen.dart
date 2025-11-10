import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../login/domain/entity/user_entity.dart';
import '../../../resource_home/parent/resource_screen.dart';
import '../../../resource_home/shared_media/presentation/shared_media_screen.dart';
import '../bloc/bottom_nav_bloc.dart';
import '../bloc/bottom_nav_state.dart';
import 'bottom_navigation.dart';
import 'home_page.dart';

class HomeScreen extends StatelessWidget {
  final UserEntity user;

  const HomeScreen({super.key, required this.user});



  @override
  Widget build(BuildContext context) {
    final List<Widget> pages =  [
      HomePage(user: user),
      Center(child: Text("Chat Page")),
      Center(child: Text("Magic Page")),
      Center(child: Text("Notifications Page")),
      ResourceScreen(),
    ];
    return BlocBuilder<BottomNavBloc, BottomNavState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(

            body: IndexedStack(
              index: state.selectedIndex,
              children: pages,
            ),
            bottomNavigationBar:  CustomBottomNav(),
          ),
        );
      },
    );
  }
}

