import 'dart:convert';

List<Info> infoFromJson(String str) =>
    List<Info>.from(json.decode(str).map((x) => Info.fromJson(x)));

String infoToJson(List<Info> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Info {
  String sourceUrl;
  String thumbnailUrl;
  String title;
  String videoId;

  Info({
    required this.sourceUrl,
    required this.thumbnailUrl,
    required this.title,
    required this.videoId,
  });

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        sourceUrl: json["source_url"],
        thumbnailUrl: json["thumbnail_url"],
        title: json["title"],
        videoId: json["video_id"],
      );

  Map<String, dynamic> toJson() => {
        "source_url": sourceUrl,
        "thumbnail_url": thumbnailUrl,
        "title": title,
        "video_id": videoId,
      };
}
