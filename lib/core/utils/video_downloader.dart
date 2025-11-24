import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as p;

class VideoDownloader {
  /// دانلود ویدیو و ذخیره در Downloads گوشی
  static Future<void> downloadVideo({
    required String url,
    required BuildContext context,
    Function(int progress)? onProgress, // callback برای نمایش درصد
    Function(String filePath)? onComplete, // callback وقتی دانلود تموم شد
  }) async {
    if (url.isEmpty) return;

    // درخواست اجازه ذخیره در External Storage
    var status = await Permission.storage.request();
    if (!status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Storage permission denied')),
      );
      return;
    }

    try {
      final dio = Dio();

      // مسیر Downloads
      final downloadsDir = Directory('/storage/emulated/0/Download');
      if (!await downloadsDir.exists()) {
        await downloadsDir.create(recursive: true);
      }

      final fileName = url.split('/').last.split('?').first;
      final filePath = p.join(downloadsDir.path, fileName);

      await dio.download(
        url,
        filePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            final progress = (received / total * 100).toInt();
            print('📥 Download progress: $progress%');
            if (onProgress != null) onProgress(progress);
          }
        },
      );

      if (onComplete != null) onComplete(filePath); // مسیر فایل برگردانده میشه

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('saved to Downloads: $fileName')),
      );
    } catch (e) {
      print('❌ Download error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to download ')),
      );
      if (onComplete != null) onComplete(''); // اگر دانلود نشد، مسیر خالی برگرده
    }
  }
}
