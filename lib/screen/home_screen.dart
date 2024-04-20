import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yt_download_app/component/nav_bar.dart';
import 'package:yt_download_app/component/yt_download.dart';
import 'package:yt_download_app/model/info.dart';
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
  int _progressOfDown = 0;
  bool isVideo = true;
  // bool _isItemLoading = false;

  final List<DownloadWidget> downloadItems = [];
  final List<bool> _loadingStates = [];
  final List<int> _loadingProgress = [];
  // late List<bool> _loadingStates;

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
    // _loadingStates = List.filled(downloadItems.length, false);
    requestStoragePermission();
  }

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
                Transform.scale(
                  scale: 0.9,
                  child: LiteRollingSwitch(
                    value: true,
                    textOn: 'Video',
                    textOff: 'Audio',
                    colorOn: const Color.fromARGB(255, 23, 85, 152),
                    colorOff: const Color.fromARGB(255, 47, 44, 44),
                    textOnColor: const Color.fromARGB(255, 255, 255, 255),
                    iconOn: Icons.video_collection,
                    iconOff: Icons.audio_file,
                    textSize: 17.0,
                    onChanged: (bool state) {
                      //Use it to manage the different states
                      setState(() {
                        isVideo = state;
                      });
                      print('Current State of SWITCH IS: $state');
                    },
                    onTap: () {},
                    onDoubleTap: () {},
                    onSwipe: () {},
                  ),
                ),
                Visibility(
                  visible: downloadItems.isEmpty && !_isLoading,
                  child: Transform.scale(
                      scale: 0.5, child: Image.asset("assets/images/WME5.gif")),
                ),
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
                  log('progress count $_progressOfDown');
                  return DownloadWidget(
                    title: downloadItem.title,
                    url: downloadItem.url,
                    img: downloadItem.img, // Pass img if available
                    progress: _loadingProgress[index],
                    loading: _loadingStates[index],
                    onPressed: () async {
                      setState(() {
                        _loadingStates[index] =
                            true; // Set loading state for this widget
                      });
                      bool a = await ApiService().downloadVideo(
                        {
                          'videos': [downloadItem.videoId],
                          'isVideo': isVideo
                        },
                        (p0) {
                          log("Download Progress of ${downloadItem.title} : $p0");
                          setState(() {
                            _loadingProgress[index] = p0;
                          });
                        },
                      );
                      // setState(() {
                      //   _loadingStates[index] = false;
                      // });
                    },
                    // setLoadingState: (bool loading) {
                    //   // Callback function to update loading state
                    //   setState(() {
                    //     downloadItem.loading = loading;
                    //   });
                    // },
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
            onPressed: () {},
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
              setState(() {
                _isLoading = true;
              });
              _handleButtonClick();
              // downloadItems.clear();
              // downloadItems.addAll(downloadItems2);
            },
          ),
        ),
        style: const TextStyle(
          color: Colors.white,
        ),
        textInputAction: TextInputAction.done,
        onSubmitted: (text) {
          setState(() {
            _isLoading = true;
          });
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
      showSnakBar('Please enter a YouTube link');
      setState(() {
        _isLoading = false;
        _progressOfDown = 0;
        downloadItems.clear();
      });
      return;
    }

    downloadItems.clear();
    try {
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
                  progress: 0,
                  onPressed: () {},
                ))
            .toList());
        _isLoading = false;
        _progressOfDown = 0;
        _loadingProgress.clear();
        _loadingStates.clear();
      });

      downloadItems.forEach((element) {
        setState(() {
          _loadingStates.add(false);
          _loadingProgress.add(0);
        });
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _progressOfDown = 0;
      });
      showSnakBar('Please enter a valid YouTube link or Try again later');
    }
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

  void showSnakBar(String titles) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(titles),
      behavior: SnackBarBehavior.floating,
      elevation: 10.0,
      backgroundColor: Colors.redAccent,
      margin: const EdgeInsets.only(bottom: 85, right: 30, left: 30),
    ));
  }

  bool isYoutubePlaylist(String url) {
    return url.contains("playlist") || url.contains("list");
  }
}
