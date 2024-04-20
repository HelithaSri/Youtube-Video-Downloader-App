import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yt_download_app/component/download_item.dart';
import 'package:yt_download_app/component/nav_bar.dart';
import 'package:yt_download_app/service/storag_service.dart';

class DownloadHistoryScreen extends StatefulWidget {
  const DownloadHistoryScreen({super.key});

  @override
  State<DownloadHistoryScreen> createState() => _DownloadHistoryScreenState();
}

class _DownloadHistoryScreenState extends State<DownloadHistoryScreen> {
  List<DownloadItem> downloadItems = [];

  bool _isLoading = true;

  Future<void> requestStoragePermission() async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      // Access granted, proceed with storage operations
    } else if (status.isDenied) {
      // Permission denied
      openAppSettings();
    } else if (status.isPermanentlyDenied) {
      // Permission permanently denied, open app settings
      openAppSettings();
    }
  }

  @override
  void initState() {
    super.initState();
    getAllDownloadFiles();
    requestStoragePermission();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text('Downloads'.toUpperCase()),
            centerTitle: true,
            titleTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
            backgroundColor: const Color.fromRGBO(27, 30, 50, 1),
          ),
          backgroundColor: const Color.fromRGBO(27, 30, 60, 1),
          body: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount:
                      downloadItems.isNotEmpty ? downloadItems.length + 1 : 1,
                  itemBuilder: (context, index) {
                    if (index == downloadItems.length) {
                      return const SizedBox(height: 75.0);
                    }
                    final downloadItem = downloadItems[index];
                    return DownloadItem(
                      title: downloadItem.title,
                      img: downloadItem.img,
                      isVideo: downloadItem.isVideo,
                      path: downloadItem.path,
                    );
                  },
                ),
        ),
        FloatingNavBar(
          rightIcon: Icons.arrow_back_ios,
          nav: () {
            Navigator.pop(
              context,
            );
          },
        ),
      ],
    );
  }

  Future<void> getAllDownloadFiles() async {
    try {
      setState(() {
        _isLoading = true;
      });
      List<DownloadItem> items = await StorageServices().retriveDownloads();
      setState(() {
        downloadItems.addAll(items);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      log('Error fetching Photos from API, data: $e');
    }
  }
}
