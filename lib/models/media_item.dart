enum MediaType { video, audio, image, document }

class MediaItem {
  final String title;
  final String category;
  final String thumbnail;
  final String url;
  final MediaType type;
  final String? duration;
  final String? description;

  MediaItem({
    required this.title,
    required this.category,
    required this.thumbnail,
    required this.url,
    required this.type,
    this.duration,
    this.description,
  });
}
