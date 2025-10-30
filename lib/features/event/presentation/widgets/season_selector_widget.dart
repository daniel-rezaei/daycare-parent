
import 'package:flutter/material.dart';
import 'package:parent_app/resorces/pallete.dart';

enum Season { spring, summer, fall, winter }

class SeasonSelector extends StatelessWidget {
  final Season selected;
  final Function(Season) onSelect;

  const SeasonSelector({
    super.key,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    const textStyleInactive = TextStyle(color: Colors.grey, fontSize: 16);
    const textStyleActive =
    TextStyle(color: Colors.purple, fontSize: 16, fontWeight: FontWeight.bold);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildButton('Spr 2025', Season.spring, textStyleActive, textStyleInactive),
            const SizedBox(width: 8),
            _buildButton('Sum 2025', Season.summer, textStyleActive, textStyleInactive),
            const SizedBox(width: 8),
            _buildButton('Fall 2025', Season.fall, textStyleActive, textStyleInactive),
            const SizedBox(width: 8),
            _buildButton('Win 2025', Season.winter, textStyleActive, textStyleInactive),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(
      String label,
      Season season,
      TextStyle active,
      TextStyle inactive,
      ) {
    final bool isSelected = selected == season;
    final parts = label.split(' ');
    return GestureDetector(
      onTap: () => onSelect(season),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
          boxShadow: isSelected
              ? [BoxShadow(color: Colors.purple.withOpacity(0.15), blurRadius: 10)]
              : [],
        ),
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: parts[0],

                style: isSelected
                    ? active.copyWith(color: Palette.txtPrimary) .copyWith(
                  fontSize: 24
                )// رنگ بنفش
                    : inactive.copyWith(color: Palette.textForeground).copyWith(
                  fontSize: 14
                ),


              ),
              TextSpan(
                text: parts[1], // بخش دوم
                style: isSelected
                    ? active.copyWith(color: Palette.textSecondaryForeground80).copyWith(
                  fontSize: 18
                ) // رنگ بقیه
                    : inactive.copyWith(color: Palette.textSecondaryForeground80)
                .copyWith(fontSize: 14),
              ),
            ],
          ),
        )
        ,
      ),
    );
  }
}

