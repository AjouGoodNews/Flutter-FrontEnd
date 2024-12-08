class NewsArticle {
  final int id;
  final String title;
  final String keyword1;
  final String keyword2;
  final String keyword3;
  final String shortcut1;
  final String shortcut2;
  final String shortcut3;
  final DateTime publishedDate;

  NewsArticle({
    required this.id,
    required this.title,
    required this.keyword1,
    required this.keyword2,
    required this.keyword3,
    required this.shortcut1,
    required this.shortcut2,
    required this.shortcut3,
    required this.publishedDate,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      id: json['id'],
      title: json['title'],
      keyword1: json['keyword1'],
      keyword2: json['keyword2'],
      keyword3: json['keyword3'],
      shortcut1: json['shortcut1'],
      shortcut2: json['shortcut2'],
      shortcut3: json['shortcut3'],
      publishedDate: DateTime.parse(json['published_date']), // JSON에서 LocalDateTime을 DateTime으로 변환
    );
  }
}