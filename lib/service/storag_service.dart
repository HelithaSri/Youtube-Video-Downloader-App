import 'dart:developer';
import 'dart:io';

import 'package:yt_download_app/component/download_item.dart';
import 'package:yt_download_app/service/api_service.dart';

class StorageServices {
  Future<List<DownloadItem>> retriveDownloads() async {
    Directory directory = await ApiService().getLocalDirectory();

    final List<DownloadItem> files = [];
    final List<FileSystemEntity> entities = await directory.list().toList();
    for (final entity in entities) {
      final extension = entity.path.split('.').last.toLowerCase();
      log(extension.startsWith("mp4").toString());
      if (extension == 'mp4' || extension == 'mp3') {
        final title = entity.path
            .split('/')
            .last
            .split('.')
            .first; // Extract title from filename
        files.add(DownloadItem(
            title: title,
            isVideo: extension.startsWith("mp4"),
            path: entity.path));
      }
    }
    return files;
  }
}
