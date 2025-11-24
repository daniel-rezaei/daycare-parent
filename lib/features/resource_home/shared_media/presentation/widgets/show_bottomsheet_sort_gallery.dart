import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../resorces/pallete.dart';
import '../bloc/shared_media_bloc.dart';
import '../bloc/shared_media_event.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../resorces/pallete.dart';
import '../bloc/shared_media_bloc.dart';
import '../bloc/shared_media_event.dart';

void showBottomSheetSortGallery(BuildContext context) {
  final List<String> sortOptions = [
    'Newest',
    'Oldest',
    'Top Activity',
    'Photo Only',
    'Video Only',
  ];

  String selectedOption = 'Newest'; // پیش‌فرض

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (bottomSheetContext) {
      return BlocProvider.value(
        value: context.read<SharedMediaBloc>(), // ⚡ انتقال Bloc به BottomSheet
        child: StatefulBuilder(
          builder: (context, setState) {
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset('assets/images/ic_sort_gallery.svg'),
                          const SizedBox(width: 6),
                          Text(
                            "Sort",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey[800],
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
                  Divider(height: 1, color: Palette.bgBorder),
                  const SizedBox(height: 12),

                  // Sort options
                  ...sortOptions.map((option) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            selectedOption = option;
                          });

                          // ⚡ ارسال Event به Bloc
                          context.read<SharedMediaBloc>().add(
                            SortSharedMediaEvent(sortBy: option),
                          );

                          Navigator.pop(context); // بستن BottomSheet
                        },
                        child: Row(
                          children: [
                            const SizedBox(width: 8),
                            Text(
                              option,
                              style: TextStyle(
                                fontSize: 16,
                                color: Palette.textForeground,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),

                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}



