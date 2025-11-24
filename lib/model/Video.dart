
class Video {
  static final Video RECOMMENDED = Video(id: "RECOMMENDED", title: "recommended", thumbnailUrl: "", createdAt: "");

  final String id;
  final String title;
  final String thumbnailUrl;
  final String createdAt;

  Video({required this.id, required this.title, required this.thumbnailUrl,     required this.createdAt,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    final embedUrl = json['uri'] as String;
    final videoId = Uri.parse(embedUrl).pathSegments.last;
    final title = json['name'] as String;
    final thumbnailUrl = json['picture_base_link'] as String;
    final createdAt = json['created_at'] ?? '';

    return Video(id: videoId, title: title, thumbnailUrl: thumbnailUrl ,       createdAt: createdAt,
    );
  }
}
