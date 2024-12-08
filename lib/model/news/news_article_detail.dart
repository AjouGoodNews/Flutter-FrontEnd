class NewsArticleDetail {
  final String title;
  final String? publisher;
  final String? reporter;
  final String shortcut;
  final String content;
  final String keyword1;
  final String keyword2;
  final String keyword3;
  final String keywordDetail1;
  final String keywordDetail2;
  final String keywordDetail3;
  final DateTime publishedDate;

  NewsArticleDetail({
    required this.title,
    this.publisher,
    this.reporter,
    required this.shortcut,
    required this.content,
    required this.keyword1,
    required this.keyword2,
    required this.keyword3,
    required this.keywordDetail1,
    required this.keywordDetail2,
    required this.keywordDetail3,
    required this.publishedDate,
  });

  factory NewsArticleDetail.fromJson(Map<String, dynamic> json) {
    return NewsArticleDetail(
      title: json['title'],
      publisher: json['publisher'] as String?,
      reporter: json['reporter'] as String?,
      shortcut: json['shortcut'],
      content: json['content'],
      keyword1: json['keyword1'],
      keyword2: json['keyword2'],
      keyword3: json['keyword3'],
      keywordDetail1: json['keywordDetail1'],
      keywordDetail2: json['keywordDetail2'],
      keywordDetail3: json['keywordDetail3'],
      publishedDate: DateTime.parse(json['published_date']), // JSON에서 LocalDateTime을 DateTime으로 변환
    );
  }
}