import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../bloc/bottom_nav_bloc.dart';
import '../bloc/bottom_nav_event.dart';
import '../bloc/bottom_nav_state.dart';

class CustomBottomNav extends StatelessWidget {
  final List<Map<String, String>> icons = [
    {
      "default": "assets/images/ic_home.svg",
      "active": "assets/images/ic_home_color.svg",
    },
    {
      "default": "assets/images/ic_message.svg",
      "active": "assets/images/ic_message_color.svg",
    },
    {
      "default": "assets/images/ic_default_navigation.svg",
      "active": "assets/images/ic_default_navigation.svg",
    },
    {
      "default": "assets/images/ic_notif.svg",
      "active": "assets/images/ic_notification_color.svg",
    },
    {
      "default": "assets/images/ic_galery.svg",
      "active": "assets/images/ic_resources_color.svg",
    },
  ];


   CustomBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBloc, BottomNavState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 12,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(icons.length, (index) {
              final isSelected = state.selectedIndex == index;
              final iconPath = isSelected
                  ? icons[index]["active"]!
                  : icons[index]["default"]!;

              if (index == 2) {
                // دکمه وسط
                return _buildCenterItem(context, index: index, assetName: iconPath);
              }

              return _buildNavItem(
                context,
                index: index,
                selected: isSelected,
                assetName: iconPath,
              );
            }),
          ),
        );
      },
    );
  }

  Widget _buildNavItem(
      BuildContext context, {
        required int index,
        required bool selected,
        required String assetName,
      }) {
    return GestureDetector(
      onTap: () => context.read<BottomNavBloc>().add(TabChanged(index)),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: selected ? Colors.grey.withOpacity(0.1) : Colors.transparent,
        ),
        child: SvgPicture.asset(
          assetName,
        ),
      ),
    );
  }

  Widget _buildCenterItem(
      BuildContext context, {
        required int index,
        required String assetName,
      }) {
    return GestureDetector(
      onTap: () => context.read<BottomNavBloc>().add(TabChanged(index)),
      child: SvgPicture.asset(
        assetName,
      ),
    );
  }
}


