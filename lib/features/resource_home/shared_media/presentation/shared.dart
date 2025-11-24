import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:parent_app/features/resource_home/shared_media/domain/entity/shared_media_entity.dart';
import 'package:parent_app/features/resource_home/shared_media/presentation/widgets/media_grid_item.dart';
import 'package:parent_app/features/resource_home/shared_media/presentation/widgets/show_art_bottom_sheet.dart';
import 'package:parent_app/features/resource_home/shared_media/presentation/widgets/show_bottomsheet_sort_gallery.dart';
import 'package:parent_app/features/resource_home/shared_media/presentation/widgets/show_filter_bottom_sheet.dart';
import 'package:parent_app/resorces/pallete.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/network/dio_client.dart';
import '../../../../core/utils/thumbnail.dart';
import '../../../home_page/presentation/bloc/child_bloc.dart';
import '../../../home_page/presentation/bloc/child_state.dart';
import '../data/repository/shared_media_repository_impl.dart';
import '../domain/usecase/get_shared_media_usecase.dart';
import 'bloc/shared_media_bloc.dart';
import 'bloc/shared_media_event.dart';
import 'bloc/shared_media_state.dart';

class SharedScreen extends StatelessWidget {
  final String childId;
  const SharedScreen({super.key, required this.childId});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (_) {
        final bloc = SharedMediaBloc(
          GetSharedMediaUseCase(
            SharedMediaRepositoryImpl(DioClient()),
          ),
        );
        bloc.add(LoadSharedMediaEvent(childId: childId)); // ✅ اینجا مشکلی نیست
        return bloc;
      },
      child: _SharedScreenView(childId: childId),
    );

  }
}

class _SharedScreenView extends StatefulWidget {
  final String childId;
  const _SharedScreenView({required this.childId});

  @override
  State<_SharedScreenView> createState() => _SharedScreenViewState();
}

class _SharedScreenViewState extends State<_SharedScreenView> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final sharedMediaBloc = context.read<SharedMediaBloc>();

    return Stack(
      children: [
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
            title: const Text('Shared Media', style: TextStyle(color: Colors.black)),
          ),
          body: SizedBox(
            height: screenHeight,
            child: Column(
              children: [
                // Search + Filter
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search option...',
                            prefixIcon: const Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Icon(Icons.search),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          onChanged: (value) {
                            sharedMediaBloc.add(
                              ApplySearchSharedMediaEvent(query: value),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () async {
                          final selectedFilters = await showFilterBottomSheet(context);
                          if (selectedFilters != null && selectedFilters.isNotEmpty) {
                            sharedMediaBloc.add(
                              ApplyFilterSharedMediaEvent(
                                filters: Map<String, String>.from(selectedFilters),
                              ),
                            );
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.filter_alt),
                        ),
                      ),
                    ],
                  ),
                ),
                // Media Grid
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
                      child: BlocBuilder<SharedMediaBloc, SharedMediaState>(
                        builder: (context, state) {
                          if (state is SharedMediaLoading) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          if (state is SharedMediaError) {
                            return Center(child: Text(state.message));
                          }
                          if (state is SharedMediaLoaded) {
                            if (state.mediaItems.isEmpty) {
                              return const Center(child: Text('No media available.'));
                            }

                            // گروه‌بندی بر اساس تاریخ
                            final groupedItems = <String, List<MediaItem>>{};
                            for (var item in state.mediaItems) {
                              String dateKey = getDateLabel(item.createdAt.isNotEmpty ? item.createdAt : '');
                              groupedItems.putIfAbsent(dateKey, () => []).add(item);
                            }

                            return SingleChildScrollView(
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
                                        GestureDetector(
                                          onTap: () {
                                            showBottomSheetSortGallery(context);
                                          },
                                          child: SvgPicture.asset('assets/images/ic_sort_gallery.svg'),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ...groupedItems.entries.map((entry) {
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
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
                                            final media = entry.value[index];
                                            return GestureDetector(
                                              onTap: () {

                                                  showModalBottomSheet(
                                                    context: context,
                                                    isScrollControlled: true,
                                                    backgroundColor: Colors.transparent,
                                                    builder: (_) => ArtBottomSheet(
                                                      videoUrl: media.imagePath,
                                                      videoUrlThumbnail: media.thumbnailPath ?? '',
                                                      caption: media.caption ?? '',
                                                      tag: media.tag ?? '',
                                                      privacy: media.privacy,
                                                      role: media.role ?? '',
                                                      createdAt: media.createdAt, creatorUserId: media.uploadedBy ?? '',
                                                    ),
                                                  );

                                              },
                                              child: MediaGridItem(item: media),
                                            );
                                          },
                                        ),
                                        const SizedBox(height: 16),
                                      ],
                                    );
                                  }).toList(),
                                ],
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
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

  String getDateLabel(String dateString) {
    final date = DateTime.tryParse(dateString) ?? DateTime.now();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final itemDate = DateTime(date.year, date.month, date.day);

    if (itemDate == today) return 'Today';
    if (itemDate == yesterday) return 'Yesterday';
    return '${date.day}/${date.month}/${date.year}';
  }

  String getFileUrl(List<String>? fileIds) {
    if (fileIds == null || fileIds.isEmpty) return '';
    return 'http://51.79.53.56:8055/assets/${fileIds.first}?access_token=1C1ROl_Te_A_sNZNO00O3k32OvRIPcSo';
  }
}
