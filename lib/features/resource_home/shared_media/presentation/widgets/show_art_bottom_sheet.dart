import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:video_player/video_player.dart';
import '../../../../../core/utils/local_storage.dart';
import '../../../../../resorces/pallete.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:video_player/video_player.dart';
import '../../../../../resorces/pallete.dart';
import '../../../../../features/login/data/model/user_model.dart';

class ArtBottomSheet extends StatefulWidget {
  final String videoUrl;
  final String tag;
  final String videoUrlThumbnail;
  final String caption;
  final String createdAt;
  final List<String>? privacy;


  const ArtBottomSheet({
    super.key,
    required this.videoUrl,
    required this.tag,
    required this.caption,
    required this.createdAt,
    this.videoUrlThumbnail = '',
    this.privacy
  });

  @override
  State<ArtBottomSheet> createState() => _ArtBottomSheetState();
}

class _ArtBottomSheetState extends State<ArtBottomSheet> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  UserModel? _user;

  @override
  void initState() {
    super.initState();
    _loadUser();
    if (widget.videoUrl.isNotEmpty) {
      _controller = VideoPlayerController.network(widget.videoUrl)
        ..initialize().then((_) {
          setState(() {
            _isInitialized = true;
          });
        });
    }
  }

  Future<void> _loadUser() async {
    final user = await LocalStorage.getUser();
    if (mounted) {
      setState(() {
        _user = user;
      });
    }
  }

  String _formatTime(String dateTime) {
    final dt = DateTime.tryParse(dateTime) ?? DateTime.now();
    final hour = dt.hour > 12 ? dt.hour - 12 : dt.hour;
    final minute = dt.minute.toString().padLeft(2, '0');
    final period = dt.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }


  @override
  void dispose() {
    if (widget.videoUrl.isNotEmpty) _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header با tag و دکمه دانلود
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Palette.bgColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  widget.tag,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Palette.txtPrimary,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Palette.borderInput, width: 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                  SvgPicture.asset('assets/images/ic_download_media.svg'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Video / Thumbnail
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              height: screenHeight / 3,
              width: double.infinity,
              color: Colors.black12,
              child: Stack(
                children: [
                  if (!_isInitialized)
                    widget.videoUrlThumbnail.isNotEmpty
                        ? Image.network(
                      widget.videoUrlThumbnail,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    )
                        : Container(color: Colors.black12),
                  if (_isInitialized)
                    SizedBox.expand(
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                          width: _controller.value.size.width,
                          height: _controller.value.size.height,
                          child: VideoPlayer(_controller),
                        ),
                      ),
                    ),
                  if (widget.videoUrl.isNotEmpty)
                    Positioned.fill(
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _controller.value.isPlaying
                                  ? _controller.pause()
                                  : _controller.play();
                            });
                          },
                          child: _controller.value.isPlaying
                              ? const SizedBox.shrink()
                              : Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(10),
                            child: SvgPicture.asset(
                              'assets/images/ic_play.svg',
                              width: 60,
                              height: 60,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Info Row با اسم و آواتار کاربر لاگین شده
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundImage: getUserAvatar(_user?.photo),
              ),
              const SizedBox(width: 8),
              Text(
                _user != null
                    ? '${_user!.firstName} ${_user!.lastName}'
                    : 'Loading...',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Palette.textForeground,
                ),
              ),
              const SizedBox(width: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Palette.bgColorPink,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  widget.privacy?.join(', ') ?? '',
                  style: TextStyle(
                    color: Palette.txtTagForeground2,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  _formatTime(widget.createdAt ?? ''),
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Palette.textMutedForeground,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Description از سرور
          Text(
            widget.caption.isNotEmpty ? widget.caption : 'No caption',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Palette.textForeground,
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

ImageProvider getUserAvatar(String? photoId) {
  if (photoId == null || photoId.isEmpty) {
    return const AssetImage('assets/images/avatar_placeholder.png');
  }

  final url = getUserPhotoUrl(photoId);
  if (url.isEmpty) {
    return const AssetImage('assets/images/avatar_placeholder.png');
  }

  return CachedNetworkImageProvider( url);
}

String getUserPhotoUrl(String id) {
  if (id.isEmpty) return '';
  if (id.startsWith('http')) return id;
  return 'http://51.79.53.56:8055/assets/$id?access_token=1C1ROl_Te_A_sNZNO00O3k32OvRIPcSo';
}

