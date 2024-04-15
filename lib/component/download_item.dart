import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DownloadItem extends StatefulWidget {
  const DownloadItem({
    super.key,
    required this.title,
    this.img =
        "https://www.stehle-int.com/EN/US/media/PIC_IMG_ALG_youtube-default-thumbnail_IN.png",
  });

  final String title;
  final String img;

  @override
  State<DownloadItem> createState() => _DownloadItemState();
}

class _DownloadItemState extends State<DownloadItem> {
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
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10.0,
                            color: Colors.white,
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
            // flex: 1,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.play_arrow),
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
