import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../resorces/pallete.dart';

class CategoryItem extends StatefulWidget {
  final String? title;
  final String? count;
  final String icon;
  final List<Widget>? children;
  final VoidCallback? onExpand;

  const CategoryItem({
    super.key,
    required this.title,
    this.count,
    required this.icon,
    this.children,
    this.onExpand,
  });

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: () {
              // Only allow expand if count provided (badge present)
              if (widget.count != null && widget.count!.isNotEmpty) {
                // if we are expanding now and need to trigger loader
                if (!isExpanded && widget.onExpand != null) {
                  widget.onExpand!();
                }
                setState(() => isExpanded = !isExpanded);
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(widget.icon, width: 48, height: 48),
                    const SizedBox(width: 8),
                    Text(
                      widget.title ?? '',
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Palette.bgColor,
                      ),
                      child: Text(
                        widget.count ?? '# No Items',
                        style: TextStyle(
                          color: (widget.count != null)
                              ? Palette.txtTagForeground3
                              : Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    if (widget.children != null && widget.children!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(left: 6.0),
                        child: Icon(
                          isExpanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: Colors.grey.shade600,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),

          if (isExpanded && widget.children != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(children: widget.children!),
            ),
        ],
      ),
    );
  }
}
