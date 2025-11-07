
import 'package:flutter/material.dart';

import '../../../../resorces/pallete.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Function(String)? onSeasonChanged;
  const CustomAppBar({super.key, this.onSeasonChanged});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  String selectedSeason = 'Season';

  final List<String> seasons = ['Season','Spr', 'Sum', 'Fall', 'Win'];

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Palette.textSecondaryForeground80),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text('Event', style: TextStyle(color: Palette.textForeground)),
      actions: [
        Padding(
          padding: const EdgeInsets.all( 12.0),
          child: Container(

            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedSeason,
                dropdownColor: Colors.white,
                icon: const Icon(Icons.keyboard_arrow_down, color:
               Palette.textSecondaryForeground80),
                items: seasons.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(value,
                          style: TextStyle(
                            color: Palette.textSecondaryForeground80,
                            fontSize: 14,
                            fontWeight: value == selectedSeason
                                ? FontWeight.w500
                                : FontWeight.normal,
                          )),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedSeason = value!;
                  });
                  widget.onSeasonChanged?.call(value!);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

}
