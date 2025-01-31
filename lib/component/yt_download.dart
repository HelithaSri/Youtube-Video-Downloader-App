import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DownloadWidget extends StatefulWidget {
  const DownloadWidget({
    super.key,
    required this.title,
    required this.url,
    this.videoId = "1",
    required this.progress,
    this.loading = false,
    required this.onPressed,
    // required this.setLoadingState,
    this.img =
        "https://www.stehle-int.com/EN/US/media/PIC_IMG_ALG_youtube-default-thumbnail_IN.png",
  });

  final String title;
  final String url;
  final String img;
  final String videoId;
  final int progress;
  final bool loading;
  final VoidCallback onPressed;
  // final Function(bool) setLoadingState;

  @override
  State<DownloadWidget> createState() => _DownloadWidgetState();
}

class _DownloadWidgetState extends State<DownloadWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: const BoxDecoration(
          // color: Colors.yellow,
          ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: ClipRRect(
                    // Add ClipRRect for rounded corners
                    borderRadius: BorderRadius.circular(10.0),
                    child: SizedBox(
                      width: 100.0,
                      height: 100.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        // child: Image.network(
                        //   widget.img,
                        //   fit: BoxFit.cover,
                        //   errorBuilder: (context, error, stackTrace) {
                        //     return Image.asset(
                        //       "assets/images/no-img.png",
                        //       fit: BoxFit.cover,
                        //     );
                        //   },
                        // ),
                        child: CachedNetworkImage(
                          imageUrl: widget.img,
                          fit: BoxFit.cover,
                          // progressIndicatorBuilder:
                          //     (context, url, downloadProgress) => Container(
                          //   // Use Container
                          //   width: 25.0,
                          //   height: 50.0,
                          //   child: CircularProgressIndicator(
                          //     value: downloadProgress.progress,
                          //     strokeWidth: 2.0,
                          //     strokeCap: StrokeCap.square,
                          //     backgroundColor: Colors.black45,
                          //   ),
                          // ),
                          errorWidget: (context, url, error) => Image.asset(
                            "assets/images/no-img.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    // decoration: const BoxDecoration(color: Colors.red),
                    // height: 100.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title.trim(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10.0,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          widget.url.trim(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.white24,
                            fontSize: 10.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 44,
              child: Visibility(
                visible: !widget.loading, // Show the button if not loading
                replacement: Visibility(
                  replacement: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.done),
                    color: Colors.white,
                  ),
                  visible: widget.progress <
                      100, // Show progress indicator if progress is less than 100
                  child: Transform.scale(
                    scale: 0.6,
                    child: CircularProgressIndicator(
                      value: widget.progress / 100,
                    ),
                  ),
                ),
                child: IconButton(
                  onPressed: () {
                    // Update loading state using callback function
                    // widget.setLoadingState(true);
                    // Call the onPressed callback
                    widget.onPressed();
                  },
                  icon: const Icon(Icons.downloading),
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
