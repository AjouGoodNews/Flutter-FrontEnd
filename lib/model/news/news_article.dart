class NewsArticle {
  final int id;
  final String title;
  final String shortcut;
  final String keyword1;
  final String keyword2;
  final String keyword3;
  final String keyword1Detail;
  final String keyword2Detail;
  final String keyword3Detail;
  final DateTime publishedDate;

  NewsArticle({
    required this.id,
    required this.title,
    required this.shortcut,
    required this.keyword1,
    required this.keyword2,
    required this.keyword3,
    required this.keyword1Detail,
    required this.keyword2Detail,
    required this.keyword3Detail,
    required this.publishedDate,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      id: json['id'],
      title: json['title'],
      shortcut: json['shortcut'],
      keyword1: json['keyword1'],
      keyword2: json['keyword2'],
      keyword3: json['keyword3'],
      keyword1Detail: json['keyword1Detail'],
      keyword2Detail: json['keyword2Detail'],
      keyword3Detail: json['keyword3Detail'],
      publishedDate: DateTime.parse(json['published_date']), // JSON에서 LocalDateTime을 DateTime으로 변환
    );
  }
}