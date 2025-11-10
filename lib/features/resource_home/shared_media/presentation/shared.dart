import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:parent_app/features/resource_home/shared_media/presentation/widgets/media_grid_item.dart';
import 'package:parent_app/features/resource_home/shared_media/presentation/widgets/show_bottomsheet_sort_gallery.dart';
import 'package:parent_app/features/resource_home/shared_media/presentation/widgets/show_filter_bottom_sheet.dart';
import 'package:parent_app/resorces/pallete.dart';

class SharedScreen extends StatefulWidget {
  const SharedScreen({super.key});

  @override
  State<SharedScreen> createState() => _SharedScreenState();
}

class _SharedScreenState extends State<SharedScreen> {
  final List<MediaItem> mediaItems = [
    // Today
    MediaItem('assets/images/image_gallery.png', 'ART', 'Today'),
    MediaItem('assets/images/image_gallery.png', 'Story', 'Today'),
    MediaItem('assets/images/image_gallery.png', 'Lunch', 'Today'),
    MediaItem('assets/images/image_gallery.png', 'ART', 'Today'),
    MediaItem('assets/images/image_gallery.png', 'ART', 'Today'),
    // Yesterday
    MediaItem('assets/images/image_gallery.png', 'Outdoor', 'Yesterday'),
    MediaItem('assets/images/image_gallery.png', 'ART', 'Yesterday'),
    MediaItem('assets/images/image_gallery.png', 'Game', 'Yesterday'),
    MediaItem('assets/images/image_gallery.png', 'ART', 'Yesterday'),
    MediaItem('assets/images/image_gallery.png', 'Story', 'Yesterday'),
    MediaItem('assets/images/image_gallery.png', 'ART', 'Yesterday'),
  ];

  @override
  Widget build(BuildContext context) {
    Map<String, List<MediaItem>> groupedItems = {};
    for (var item in mediaItems) {
      groupedItems.putIfAbsent(item.date, () => []).add(item);
    }
    final screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        // Gradient background
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFB3EDFF), Color(0xFFDFF5FF)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text(
              'Shared Media',
              style: TextStyle(color: Colors.black),
            ),
            actions: [TextButton(onPressed: () {}, child: Text('Select',style:
              TextStyle(fontSize: 14,fontWeight: FontWeight.w500,
                  color: Palette.textForeground),))],
          ),
          body: SizedBox(
            height: screenHeight,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search option...',
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: SvgPicture.asset(
                                'assets/images/ic_search_media.svg',
                              ),
                            ),
                            prefixIconConstraints: const BoxConstraints(
                              minWidth: 24,
                              minHeight: 24,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      GestureDetector(
                        onTap: (){
                          showFilterBottomSheet(context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: SvgPicture.asset('assets/images/ic_filter.svg'),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Gallery',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Palette.textForeground,
                                    ),
                                  ),
                                  GestureDetector(onTap: (){
                                    showBottomSheetSortGallery(context);
                                  },
                                      child: SvgPicture.asset(
                                          'assets/images/ic_sort_gallery.svg')),
                                ],
                              ),
                            ),
                            ...groupedItems.entries.map((entry) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // 🔹 کانتینر تاریخ (Today / Yesterday)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                                    child: Center(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Palette.bgBackground80,
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                        child: Text(
                                          entry.key,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            color: Palette.textSecondaryForeground,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  // 🔹 گرید عکس‌ها
                                  GridView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 8,
                                      mainAxisSpacing: 8,
                                    ),
                                    itemCount: entry.value.length,
                                    itemBuilder: (context, index) {
                                      return MediaGridItem(item: entry.value[index]);
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                ],
                              );
                            }).toList(),

                          ],
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ],
    );
  }
}
