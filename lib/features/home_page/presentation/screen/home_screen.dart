import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bottom_nav_bloc.dart';
import '../bloc/bottom_nav_state.dart';
import 'bottom_navigation.dart';
import 'home_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<Widget> _pages = const [
    HomePage(),
    Center(child: Text("Chat Page")),
    Center(child: Text("Magic Page")),
    Center(child: Text("Notifications Page")),
    Center(child: Text("Gallery Page")),
  ];

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<BottomNavBloc, BottomNavState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(

            body: IndexedStack(
              index: state.selectedIndex,
              children: _pages,
            ),
            bottomNavigationBar:  CustomBottomNav(),
          ),
        );
      },
    );
  }
}

