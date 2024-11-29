// ignore_for_file: constant_identifier_names

// categories : POLITICS, ECONOMY, WORLD, TECH, LABOR, ENVIRONMENT, HUMAN_RIGHTS, CULTURE, LIFE
enum NewsCategory {
  POLITICS(domain: '정치'),
  ECONOMY(domain: '경제'),
  WORLD(domain: '세계'),
  TECH(domain: '테크'),
  LABOR(domain: '노동'),
  ENVIRONMENT(domain: '환경'),
  HUMAN_RIGHTS(domain: '인권'),
  CULTURE(domain: '문화'),
  LIFE(domain: '라이프');

  final String domain;

  const NewsCategory({
    required this.domain,
  });

  // 카테고리 리스트를 반환하는 메서드
  static List<String> getCategoryNames(List<NewsCategory> categories) {
    return categories.map((category) => category.name).toList();
  }

  // 카테고리 도메인 리스트를 반환하는 메서드
  static List<String> getCategoryDomains() {
    return NewsCategory.values.map((category) => category.domain).toList();
  }
}