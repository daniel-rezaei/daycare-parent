import 'package:flutter/material.dart';
import 'package:parent_app/resorces/pallete.dart';

enum Season { spring, summer, fall, winter }

class SeasonSelector extends StatefulWidget {
  final Season selected;
  final Function(Season) onSelect;

  const SeasonSelector({
    super.key,
    required this.selected,
    required this.onSelect,
  });

  @override
  State<SeasonSelector> createState() => _SeasonSelectorState();
}

class _SeasonSelectorState extends State<SeasonSelector> {
  late List<Season> _order;

  @override
  void initState() {
    super.initState();


    _order = List<Season>.from(Season.values);

    // قرار دادن فصل انتخاب‌شده وسط لیست
    final idx = _order.indexOf(widget.selected);
    if (idx != 1) { // وسط لیست index 1
      final newOrder = List<Season>.from(_order);
      final selected = newOrder.removeAt(idx);
      newOrder.insert(1, selected);
      _order = newOrder;
    }
  }


  void _onTap(Season season) {
    widget.onSelect(season);

    setState(() {
      // قرار دادن آیتم انتخاب‌شده وسط لیست
      final idx = _order.indexOf(season);
      if (idx != 1) {
        final newOrder = List<Season>.from(_order);
        newOrder.remove(season);
        // قرار دادن در ایندکس 1 (وسط) برای 4 آیتم
        newOrder.insert(1, season);
        _order = newOrder;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const textStyleInactive = TextStyle(color: Colors.grey, fontSize: 14);
    const textStyleActive =
    TextStyle(color: Colors.purple, fontSize: 16, fontWeight: FontWeight.bold);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        mainAxisSize: MainAxisSize.min, // مهم برای جلوگیری از overflow
        children: _order.map((season) {
          final isSelected = widget.selected == season;
          final label = _getLabel(season);

          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 8),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            decoration: BoxDecoration(
              color: isSelected ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(14),
              boxShadow: isSelected
                  ? [BoxShadow(color: Colors.purple.withOpacity(0.15), blurRadius: 10)]
                  : [],
            ),
            child: GestureDetector(
              onTap: () => _onTap(season),
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 250),
                style: isSelected
                    ? textStyleActive.copyWith(
                    fontSize: 24, color: Palette.txtPrimary)
                    : textStyleInactive.copyWith(
                    color: Palette.textForeground, fontSize: 14),
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: label.split(' ')[0],
                      ),
                      TextSpan(
                        text: ' ${label.split(' ')[1]}',
                        style: isSelected
                            ? textStyleActive.copyWith(
                            fontSize: 18, color: Palette.textSecondaryForeground80)
                            : textStyleInactive.copyWith(
                            color: Palette.textSecondaryForeground80, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  String _getLabel(Season season) {
    switch (season) {
      case Season.spring:
        return 'Spr 2025';
      case Season.summer:
        return 'Sum 2025';
      case Season.fall:
        return 'Fall 2025';
      case Season.winter:
        return 'Win 2025';
    }
  }
}
