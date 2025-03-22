import 'dart:convert';

class VideoModel {
  final String title;
  final String description;
  final String thumbnail;
  final Uri videoUrl;
  final String videoId;

  VideoModel( {
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.videoUrl,
    required this.videoId,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      thumbnail: json['thumbnail'],
      videoUrl: _parseUri(json['video_url']),
      videoId: json['video_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'thumbnail': thumbnail,
      'video_url': videoUrl.toString(),
      'video_id': videoId.toString(),
    };
  }

  // Convert JSON List to List of VideoModel objects
  static List<VideoModel> fromJsonList(String jsonString) {
    final Map<String, dynamic> decodedData = json.decode(jsonString);
    final List<dynamic> videoList = decodedData['videos'] ?? [];

    return videoList.map((video) => VideoModel.fromJson(video)).toList();
  }

  // Utility function to parse URLs properly
  static Uri _parseUri(String url) {
    // if (url == null || url.isEmpty) return null;
    try {
      return Uri.parse(url);
    } catch (e) {
      return Uri();
    }
  }
}
