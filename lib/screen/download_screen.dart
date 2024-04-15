import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:yt_download_app/component/download_item.dart';
import 'package:yt_download_app/component/nav_bar.dart';
import 'package:yt_download_app/model/photo.dart';
import 'package:yt_download_app/service/api_service.dart';

class DownloadHistoryScreen extends StatefulWidget {
  const DownloadHistoryScreen({super.key});

  @override
  State<DownloadHistoryScreen> createState() => _DownloadHistoryScreenState();
}

class _DownloadHistoryScreenState extends State<DownloadHistoryScreen> {
  final List<DownloadItem> downloadItems = [
    // const DownloadItem(
    //   title:
    //       " Kassai (කැස්සයි) | Dinelka Muthuarachchi X Yasho X Lahiru De Costa [Official Music Video] (4K) ",
    //   img:
    //       "https://i.ytimg.com/vi/Bm_J2bNcPUQ/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLAxocYo5yemkVrQBHa6piRSiVeTjA",
    // ),
    // const DownloadItem(
    //   title: "Poddak Saiko | පොඩ්‍ඩක් සයිකෝ | Gayya",
    //   img:
    //       "https://i.ytimg.com/vi/aNw7vbbimiY/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLArCNXZ0It1I2XvhrXaj2clNbz6dg",
    // ),
    // const DownloadItem(
    //   title:
    //       "Perambari |පෙරඹරී | Official Lyric Video| Pathum Dananjaya, Devaka Embuldeniya , Sarala Gunasekara",
    // ),
    // const DownloadItem(
    //   title: "Mob Sick - Freaky Mobbig x Manasick [ Official Music Video ]",
    //   img:
    //       "https://i.ytimg.com/vi/1WKGrVJudts/hqdefault.jpg?sqp=-oaymwE1CKgBEF5IVfKriqkDKAgBFQAAiEIYAXABwAEG8AEB-AH-CYAC0AWKAgwIABABGEcgZShiMA8=&rs=AOn4CLDGcQE7T2YJN3-SrEdGZDHZMZn1Yw",
    // ),
    // const DownloadItem(
    //   title:
    //       " Kassai (කැස්සයි) | Dinelka Muthuarachchi X Yasho X Lahiru De Costa [Official Music Video] (4K) ",
    //   img:
    //       "https://i.ytimg.com/vi/Bm_J2bNcPUQ/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLAxocYo5yemkVrQBHa6piRSiVeTjA",
    // ),
    // const DownloadItem(
    //   title: "Poddak Saiko | පොඩ්‍ඩක් සයිකෝ | Gayya",
    //   img:
    //       "https://i.ytimg.com/vi/aNw7vbbimiY/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLArCNXZ0It1I2XvhrXaj2clNbz6dg",
    // ),
    // const DownloadItem(
    //   title:
    //       "Perambari |පෙරඹරී | Official Lyric Video| Pathum Dananjaya, Devaka Embuldeniya , Sarala Gunasekara",
    // ),
    // const DownloadItem(
    //   title: "Mob Sick - Freaky Mobbig x Manasick [ Official Music Video ]",
    //   img:
    //       "https://i.ytimg.com/vi/1WKGrVJudts/hqdefault.jpg?sqp=-oaymwE1CKgBEF5IVfKriqkDKAgBFQAAiEIYAXABwAEG8AEB-AH-CYAC0AWKAgwIABABGEcgZShiMA8=&rs=AOn4CLDGcQE7T2YJN3-SrEdGZDHZMZn1Yw",
    // ),
  ];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getAllPhotos();
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

  Future<void> getAllPhotos() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final List<Photo> pic = await ApiService.fetchPhotsData();
      setState(() {
        downloadItems.addAll(pic
            .map((e) => DownloadItem(
                  title: e.title,
                  img: e.thumbnailUrl,
                ))
            .toList());
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
