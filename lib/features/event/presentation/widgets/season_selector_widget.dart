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
  final ScrollController _scrollController = ScrollController();
  final Map<Season, GlobalKey> _keys = {
    Season.spring: GlobalKey(),
    Season.summer: GlobalKey(),
    Season.fall: GlobalKey(),
    Season.winter: GlobalKey(),
  };

  @override
  void initState() {
    super.initState();
    // وقتی صفحه باز شد، تب انتخاب‌شده وسط بیاد
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToCenter(widget.selected);
    });
  }

  @override
  void didUpdateWidget(covariant SeasonSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selected != widget.selected) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToCenter(widget.selected);
      });
    }
  }

  void _scrollToCenter(Season season) {
    final items = [Season.spring, Season.summer, Season.fall, Season.winter];

    // جمع عرض آیتم‌ها قبل از انتخاب‌شده
    double offset = 0;
    for (var s in items) {
      if (s == season) break;
      final keyContext = _keys[s]?.currentContext;
      if (keyContext != null) {
        final box = keyContext.findRenderObject() as RenderBox?;
        if (box != null) offset += box.size.width + 8; // 8 فاصله بین آیتم‌ها
      }
    }

    final selectedKeyContext = _keys[season]?.currentContext;
    if (selectedKeyContext == null) return;
    final box = selectedKeyContext.findRenderObject() as RenderBox?;
    if (box == null) return;

    final double screenWidth = MediaQuery.of(context).size.width;

    // مرکز صفحه
    final double targetOffset = offset + box.size.width / 2 - screenWidth / 2;

    final double maxScroll = _scrollController.position.maxScrollExtent;
    final double clampedOffset = targetOffset.clamp(0.0, maxScroll);

    _scrollController.animateTo(
      clampedOffset,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    const textStyleInactive = TextStyle(color: Colors.grey, fontSize: 14);
    const textStyleActive =
    TextStyle(color: Colors.purple, fontSize: 16, fontWeight: FontWeight.bold);

    return SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
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
    );
  }

  Widget _buildButton(
      String label,
      Season season,
      TextStyle active,
      TextStyle inactive,
      ) {
    final bool isSelected = widget.selected == season;
    final parts = label.split(' ');

    return GestureDetector(
      key: _keys[season],
      onTap: () => widget.onSelect(season),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
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
                    ? active.copyWith(color: Palette.txtPrimary, fontSize: 24)
                    : inactive.copyWith(color: Palette.textForeground, fontSize: 14),
              ),
              TextSpan(
                text: ' ${parts[1]}',
                style: isSelected
                    ? active.copyWith(
                    color: Palette.textSecondaryForeground80, fontSize: 18)
                    : inactive.copyWith(
                    color: Palette.textSecondaryForeground80, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
