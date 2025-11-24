import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/thumbnail.dart';
import '../widgets/media_grid_item.dart';
import 'shared_media_event.dart';
import 'shared_media_state.dart';
import '../../domain/usecase/get_shared_media_usecase.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/media_grid_item.dart';
import 'shared_media_event.dart';
import 'shared_media_state.dart';
import '../../domain/usecase/get_shared_media_usecase.dart';

class SharedMediaBloc extends Bloc<SharedMediaEvent, SharedMediaState> {
  final GetSharedMediaUseCase useCase;

  SharedMediaBloc(this.useCase) : super(SharedMediaInitial()) {

    // Load
    on<LoadSharedMediaEvent>((event, emit) async {
      emit(SharedMediaLoading());
      try {
        final mediaEntities = await useCase.call(childId: event.childId);

        final mediaItems = mediaEntities.map((entity) => MediaItem(
          imagePath: getFileUrl(entity.fileIds),
          thumbnailPath: entity.thumbnail != null ? assetUrl(entity.thumbnail!['id']) : null,
          tag: entity.activityType ?? entity.tags ?? '',
          createdAt: entity.createdAt ?? '',
          isLocked: false,
          caption: entity.caption,
          privacy: entity.privacy,
          role:  entity.role,
          isVideo: entity.mediaType?.toLowerCase() == 'video',
          uploadedBy: entity.uploadedBy,
        )).toList();

        // 🔹 مرتب‌سازی پیش‌فرض: جدیدترین‌ها بالای لیست
        mediaItems.sort((a, b) {
          final dateA = DateTime.tryParse(a.createdAt) ?? DateTime(1970);
          final dateB = DateTime.tryParse(b.createdAt) ?? DateTime(1970);
          return dateB.compareTo(dateA);
        });

        emit(SharedMediaLoaded(media: mediaEntities, mediaItems: mediaItems));
      } catch (e) {
        emit(SharedMediaError(e.toString()));
      }
    });

    // Sort
    on<SortSharedMediaEvent>((event, emit) {
      if (state is SharedMediaLoaded) {
        final loadedState = state as SharedMediaLoaded;

        // 1️⃣ همیشه روی داده اصلی media کار کنیم
        List<MediaItem> sortedMedia = loadedState.media.map((entity) => MediaItem(
          imagePath: getFileUrl(entity.fileIds),
          thumbnailPath: entity.thumbnail != null ? assetUrl(entity.thumbnail!['id']) : null,
          tag: entity.activityType ?? entity.tags ?? '',
          createdAt: entity.createdAt ?? '',
          isLocked: false,
          caption: entity.caption,
          privacy: entity.privacy,
          role:  entity.role,
          isVideo: entity.mediaType?.toLowerCase() == 'video',
          uploadedBy: entity.uploadedBy,
        )).toList();

        // 2️⃣ اعمال سورت/فیلتر
        switch (event.sortBy) {
          case 'Newest':
            sortedMedia.sort((a, b) => (b.createdAt).compareTo(a.createdAt));
            break;
          case 'Oldest':
            sortedMedia.sort((a, b) => (a.createdAt).compareTo(b.createdAt));
            break;
          case 'Photo Only':
            sortedMedia = sortedMedia.where((m) => !m.isVideo).toList();
            break;
          case 'Video Only':
            sortedMedia = sortedMedia.where((m) => m.isVideo).toList();
            break;
          case 'Top Activity':
          // اضافه کردن معیار خاص اگر لازم بود
            break;
        }

        emit(SharedMediaLoaded(
          media: loadedState.media, // داده اصلی بدون تغییر
          mediaItems: sortedMedia,  // داده نمایش داده شده بعد از سورت/فیلتر
        ));
      }
    });
   //filter
    on<ApplyFilterSharedMediaEvent>((event, emit) {
      if (state is SharedMediaLoaded) {
        final loadedState = state as SharedMediaLoaded;

        List<MediaItem> filteredMedia = loadedState.media.map((entity) => MediaItem(
          imagePath: getFileUrl(entity.fileIds),
          thumbnailPath: entity.thumbnail != null ? assetUrl(entity.thumbnail!['id']) : null,
          tag: entity.activityType ?? entity.tags ?? '', // فعلاً فقط یک فیلد
          createdAt: entity.createdAt ?? '',
          isLocked: false,
          caption: entity.caption,
          privacy: entity.privacy,
          role:  entity.role,
          isVideo: entity.mediaType?.toLowerCase() == 'video',
          uploadedBy: entity.uploadedBy,
        )).toList();

        // فیلتر Media Type
        final mediaType = event.filters['by media type'];
        if (mediaType != null && mediaType != 'All') {
          filteredMedia = filteredMedia.where((m) => mediaType == 'Image' ? !m.isVideo : m.isVideo).toList();
        }

        // فیلتر Activity
        final activity = event.filters['by activity'];
        if (activity != null && activity.isNotEmpty) {
          filteredMedia = filteredMedia.where((m) {
            return m.tag.toLowerCase().contains(activity.toLowerCase());
          }).toList();
        }

        // فیلتر Event
        final eventName = event.filters['by event'];
        if (eventName != null && eventName != 'All' && eventName.isNotEmpty) {
          filteredMedia = filteredMedia.where((m) {
            return m.tag.toLowerCase().contains(eventName.toLowerCase());
          }).toList();
        }

        // فیلتر Date Range
        final dateFilter = event.filters['by date range'];
        if (dateFilter != null && dateFilter.isNotEmpty) {
          DateTime now = DateTime.now();
          filteredMedia = filteredMedia.where((m) {
            final created = DateTime.tryParse(m.createdAt) ?? now;
            switch (dateFilter) {
              case 'Today':
                return created.year == now.year && created.month == now.month && created.day == now.day;
              case 'Week till date':
                final weekStart = now.subtract(Duration(days: now.weekday - 1));
                return created.isAfter(weekStart.subtract(const Duration(seconds: 1)));
              case 'Month till date':
                return created.year == now.year && created.month == now.month;
              case 'Quarter till date':
                final currentQuarter = ((now.month - 1) ~/ 3) + 1;
                final createdQuarter = ((created.month - 1) ~/ 3) + 1;
                return created.year == now.year && createdQuarter == currentQuarter;
              case 'Year till date':
                return created.year == now.year;
              default:
                return true;
            }
          }).toList();
        }

        emit(SharedMediaLoaded(
          media: loadedState.media,
          mediaItems: filteredMedia,
        ));
      }
    });
 //search
    on<ApplySearchSharedMediaEvent>((event, emit) {
      if (state is SharedMediaLoaded) {
        final loadedState = state as SharedMediaLoaded;

        List<MediaItem> filteredMedia = loadedState.media.map((entity) => MediaItem(
          imagePath: getFileUrl(entity.fileIds),
          thumbnailPath: entity.thumbnail != null ? assetUrl(entity.thumbnail!['id']) : null,
          tag: entity.activityType ?? entity.tags ?? '',
          createdAt: entity.createdAt ?? '',
          isLocked: false,
          caption: entity.caption,
          privacy: entity.privacy,
          role: entity.role,
          isVideo: entity.mediaType?.toLowerCase() == 'video',
          uploadedBy: entity.uploadedBy,
        )).toList();

        final query = event.query.toLowerCase();

        if (query.isNotEmpty) {
          filteredMedia = filteredMedia.where((m) {
            final tagMatch = m.tag.toLowerCase().contains(query);

            final itemDate = DateTime.tryParse(m.createdAt) ?? DateTime.now();
            final now = DateTime.now();
            bool dateMatch = false;

            if (query == 'today') {
              dateMatch = itemDate.year == now.year &&
                  itemDate.month == now.month &&
                  itemDate.day == now.day;
            } else if (query == 'yesterday') {
              final yesterday = now.subtract(const Duration(days: 1));
              dateMatch = itemDate.year == yesterday.year &&
                  itemDate.month == yesterday.month &&
                  itemDate.day == yesterday.day;
            } else {
              final parts = query.split('/');
              if (parts.length == 3) {
                final day = int.tryParse(parts[0]);
                final month = int.tryParse(parts[1]);
                final year = int.tryParse(parts[2]);
                if (day != null && month != null && year != null) {
                  dateMatch = itemDate.day == day &&
                      itemDate.month == month &&
                      itemDate.year == year;
                }
              }
            }

            return tagMatch || dateMatch;
          }).toList();
        }

        emit(SharedMediaLoaded(
          media: loadedState.media,
          mediaItems: filteredMedia,
        ));
      }
    });

  }

  // Helper
  String getFileUrl(List<String>? fileIds) {
    if (fileIds == null || fileIds.isEmpty) return '';
    return 'http://51.79.53.56:8055/assets/${fileIds.first}?access_token=1C1ROl_Te_A_sNZNO00O3k32OvRIPcSo';
  }

  String assetUrl(String id) {
    return 'http://51.79.53.56:8055/assets/$id?access_token=1C1ROl_Te_A_sNZNO00O3k32OvRIPcSo';
  }
}


