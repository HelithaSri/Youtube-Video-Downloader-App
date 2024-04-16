import 'dart:collection';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:yt_download_app/component/nav_bar.dart';
import 'package:yt_download_app/component/yt_download.dart';
import 'package:yt_download_app/model/info.dart';
import 'package:yt_download_app/model/photo.dart';
import 'package:yt_download_app/screen/download_screen.dart';
import 'package:yt_download_app/service/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _urlController = TextEditingController();

  bool _isLoading = false;

  final List<DownloadWidget> downloadItems = [
    // const DownloadWidget(
    //   title:
    //       " Kassai (කැස්සයි) | Dinelka Muthuarachchi X Yasho X Lahiru De Costa [Official Music Video] (4K) ",
    //   url:
    //       "https://youtu.be/Bm_J2bNcPUQ?list=PL4sLDEuwKTh_fjsdC3hEQ60ddLdABwjOK",
    //   img:
    //       "https://i.ytimg.com/vi/Bm_J2bNcPUQ/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLAxocYo5yemkVrQBHa6piRSiVeTjA",
    // ),
    // const DownloadWidget(
    //   title: "Poddak Saiko | පොඩ්‍ඩක් සයිකෝ | Gayya",
    //   url:
    //       "https://www.youtube.com/watch?v=dOsPgc4WeKU&list=PL4sLDEuwKTh97Lrp4bEfAkwrDEZynWosn&index=10&ab_channel=RDEntertainment",
    //   img:
    //       "https://i.ytimg.com/vi/aNw7vbbimiY/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLArCNXZ0It1I2XvhrXaj2clNbz6dg",
    // ),
    // const DownloadWidget(
    //   title:
    //       "Perambari |පෙරඹරී | Official Lyric Video| Pathum Dananjaya, Devaka Embuldeniya , Sarala Gunasekara",
    //   url:
    //       "https://www.youtube.com/watch?v=dOsPgc4WeKU&list=PL4sLDEuwKTh97Lrp4bEfAkwrDEZynWosn&index=10&ab_channel=RDEntertainment",
    // ),
    // const DownloadWidget(
    //   title: "Mob Sick - Freaky Mobbig x Manasick [ Official Music Video ]",
    //   url:
    //       "https://www.youtube.com/watch?v=dOsPgc4WeKU&list=PL4sLDEuwKTh97Lrp4bEfAkwrDEZynWosn&index=10&ab_channel=RDEntertainment",
    //   img:
    //       "https://i.ytimg.com/vi/1WKGrVJudts/hqdefault.jpg?sqp=-oaymwE1CKgBEF5IVfKriqkDKAgBFQAAiEIYAXABwAEG8AEB-AH-CYAC0AWKAgwIABABGEcgZShiMA8=&rs=AOn4CLDGcQE7T2YJN3-SrEdGZDHZMZn1Yw",
    // ),
    // const DownloadWidget(
    //   title:
    //       " Kassai (කැස්සයි) | Dinelka Muthuarachchi X Yasho X Lahiru De Costa [Official Music Video] (4K) ",
    //   url:
    //       "https://youtu.be/Bm_J2bNcPUQ?list=PL4sLDEuwKTh_fjsdC3hEQ60ddLdABwjOK",
    //   img:
    //       "https://i.ytimg.com/vi/Bm_J2bNcPUQ/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLAxocYo5yemkVrQBHa6piRSiVeTjA",
    // ),
    // const DownloadWidget(
    //   title: "Poddak Saiko | පොඩ්‍ඩක් සයිකෝ | Gayya",
    //   url:
    //       "https://www.youtube.com/watch?v=dOsPgc4WeKU&list=PL4sLDEuwKTh97Lrp4bEfAkwrDEZynWosn&index=10&ab_channel=RDEntertainment",
    //   img:
    //       "https://i.ytimg.com/vi/aNw7vbbimiY/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLArCNXZ0It1I2XvhrXaj2clNbz6dg",
    // ),
    // const DownloadWidget(
    //   title:
    //       "Perambari |පෙරඹරී | Official Lyric Video| Pathum Dananjaya, Devaka Embuldeniya , Sarala Gunasekara",
    //   url:
    //       "https://www.youtube.com/watch?v=dOsPgc4WeKU&list=PL4sLDEuwKTh97Lrp4bEfAkwrDEZynWosn&index=10&ab_channel=RDEntertainment",
    // ),
    // const DownloadWidget(
    //   title: "Mob Sick - Freaky Mobbig x Manasick [ Official Music Video ]",
    //   url:
    //       "https://www.youtube.com/watch?v=dOsPgc4WeKU&list=PL4sLDEuwKTh97Lrp4bEfAkwrDEZynWosn&index=10&ab_channel=RDEntertainment",
    //   img:
    //       "https://i.ytimg.com/vi/1WKGrVJudts/hqdefault.jpg?sqp=-oaymwE1CKgBEF5IVfKriqkDKAgBFQAAiEIYAXABwAEG8AEB-AH-CYAC0AWKAgwIABABGEcgZShiMA8=&rs=AOn4CLDGcQE7T2YJN3-SrEdGZDHZMZn1Yw",
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: const Color.fromRGBO(27, 30, 53, 1),
          body: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ), // Adjust padding based on keyboard height),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                customInputField(),
                Visibility(
                  visible: _isLoading,
                  child: const CircularProgressIndicator(),
                ),
                Visibility(
                  visible: downloadItems.isNotEmpty,
                  child: fetchedDataViewer(),
                ),
              ],
            ),
          ),
        ),
        FloatingNavBar(
          rightIcon: Icons.file_download_sharp,
          nav: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const DownloadHistoryScreen()),
          ),
        ),
      ],
    );
  }

  Padding fetchedDataViewer() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        // height: 500.0,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(35, 38, 67, 1),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: [
            Visibility(
              visible: downloadItems.length > 1,
              child: headerDetails(downloadItems.length),
            ),
            // headerDetails(downloadItems.length),
            Container(
              height: downloadItems.length > 1 ? 390.0 : 175.0,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(35, 38, 67, 1),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListView.builder(
                itemCount:
                    downloadItems.isNotEmpty ? downloadItems.length + 1 : 1,
                itemBuilder: (context, index) {
                  if (index == downloadItems.length) {
                    if (downloadItems.length == 1) {
                      return const SizedBox(height: 0.0);
                    }
                    return const SizedBox(height: 75.0);
                  }
                  final downloadItem = downloadItems[index]; // Access data
                  return DownloadWidget(
                    title: downloadItem.title,
                    url: downloadItem.url,
                    img: downloadItem.img, // Pass img if available
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding headerDetails(int size) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 20.0, top: 10.0, right: 20.0, bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '$size Videos',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
          ElevatedButton(
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.green),
            ),
            onPressed: () {
              downloadItems.clear();
              downloadItems.add(const DownloadWidget(
                title:
                    "Mob Sick - Freaky Mobbig x Manasick [ Official Music Video ]",
                url:
                    "https://www.youtube.com/watch?v=dOsPgc4WeKU&list=PL4sLDEuwKTh97Lrp4bEfAkwrDEZynWosn&index=10&ab_channel=RDEntertainment",
                img:
                    "https://i.ytimg.com/vi/1WKGrVJudts/hqdefault.jpg?sqp=-oaymwE1CKgBEF5IVfKriqkDKAgBFQAAiEIYAXABwAEG8AEB-AH-CYAC0AWKAgwIABABGEcgZShiMA8=&rs=AOn4CLDGcQE7T2YJN3-SrEdGZDHZMZn1Yw",
              ));
              setState(() {});
            },
            child: const Text(
              'Download All',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget customInputField() {
    return Padding(
      padding: const EdgeInsets.only(
          left: 30.0, right: 30.0, top: 50.0, bottom: 20.0),
      child: TextField(
        controller: _urlController,
        decoration: InputDecoration(
          hintText: "YouTube Link",
          hintStyle: const TextStyle(
            color: Colors.white38,
            letterSpacing: 5.0,
          ),
          suffixIcon: IconButton(
            icon: const Icon(
              Icons.cloud_download,
              color: Colors.white,
            ),
            onPressed: () {
              _handleButtonClick();
              // downloadItems.clear();
              // downloadItems.addAll(downloadItems2);
              setState(() {
                _isLoading = true;
              });
            },
          ),
        ),
        style: const TextStyle(
          color: Colors.white,
        ),
        textInputAction: TextInputAction.done,
        onSubmitted: (text) {
          _handleButtonClick();
        },
      ),
    );
  }

  void _handleButtonClick() async {
    String url = _urlController.text;
    FocusScope.of(context).unfocus();
    if (url.isEmpty) {
      log("Please enter a YouTube link");
      downloadItems.clear();
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please enter a YouTube link'),
        behavior: SnackBarBehavior.floating,
        elevation: 10.0,
        backgroundColor: Colors.redAccent,
        margin: EdgeInsets.only(bottom: 85, right: 30, left: 30),
      ));
      return;
    }

    downloadItems.clear();
    List<Info> video = await ApiService.fetchInfo({
      'url': url,
    });
    setState(() {
      downloadItems.addAll(video
          .map((e) => DownloadWidget(
                title: e.title,
                url: e.sourceUrl,
                img: e.thumbnailUrl,
                videoId: e.videoId,
              ))
          .toList());
      _isLoading = false;
    });
    return;

    /*if (isYoutubePlaylist(url)) {
      downloadItems.clear();
      List<Photo> video = await ApiService.playlist();
      setState(() {
        downloadItems.addAll(video
            .map((e) =>
                DownloadWidget(title: e.title, url: e.url, img: e.thumbnailUrl))
            .toList());
      });
      return;
    }
    downloadItems.clear();
    List<Photo> video = await ApiService.singleVideo();
    setState(() {
      downloadItems.addAll(video
          .map((e) =>
              DownloadWidget(title: e.title, url: e.url, img: e.thumbnailUrl))
          .toList());
    });
    return;*/
  }

  bool isYoutubePlaylist(String url) {
    return url.contains("playlist") || url.contains("list");
  }
}
