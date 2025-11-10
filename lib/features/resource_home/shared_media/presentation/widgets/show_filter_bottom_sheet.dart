
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../resorces/pallete.dart';

void showFilterBottomSheet(BuildContext context) {

  final filters = {
    'by date range': [
      'Today',
      'Week till date',
      'Month till date',
      'Quarter till date',
      'Year till date'
    ],
    'by activity': ['ART', 'Story', 'Lunch', 'Outdoor'],
    'by event': [
      'All',
      'Field Trip To Zoo',
      'Parent meeting',
      'fatheer day crafting',
      'Baking Cookies'
    ],
    'by media type': ['All', 'Image', 'Video'],
    'by student': ['Sara', 'Amelia', 'Olivia', 'Liam'],
  };


  final Map<String, String> selected = {};

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset('assets/images/ic_filter.svg'),
                          const SizedBox(width: 6),
                          const Text(
                            "Filter",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                          )
                        ],
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: SvgPicture.asset('assets/images/ic_cancel.svg'),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Divider(height: 1, color: Palette.bgBorder),
                  const SizedBox(height: 20),


                  ...filters.entries.map((entry) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            entry.key,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Palette.textForeground,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: entry.value.map((option) {
                              final isSelected =
                                  selected[entry.key] == option;
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selected[entry.key] = option;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? Palette.txtTagForeground3
                                        .withOpacity(0.8)
                                        : Palette.borderPrimary20,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    option,
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : Palette.textForeground,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    );
                  }).toList(),

                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, selected);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Palette.borderPrimary80,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Save Filter",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
