class NewsItem {
  final String title;
  final String category;
  final String time;
  final String imageUrl;
  final String? content;

  NewsItem({
    required this.title,
    required this.category,
    required this.time,
    required this.imageUrl,
    this.content,
  });
}
