import 'package:dio/dio.dart';
import 'package:goodnews/enums/news_category.dart';
import 'package:goodnews/model/news/news_article.dart';

import 'package:goodnews/service/dio/dio_service.dart';
import 'package:goodnews/service/general/general_functions.dart';
import 'package:goodnews/service/logger/logger.dart';

// private Long id;
// private String title;
// private String shortcut;
// private String keyword1;
// private String keyword2;
// private String keyword3;
// private String keyword1Detail;
// private String keyword2Detail;
// private String keyword3Detail;
// private LocalDateTime published_date;

class CategoryRepository {
  final Dio _dio = DioService().dio;

  Future<List<NewsArticle>> getNewsByCategory(String category) async {
    try {
      final response = await _dio.get(
        '/api/category/0?category=$category',
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = response.data;
        print('jsonData: $jsonData');
        List<dynamic> newsListData = jsonData['newsList'] as List<dynamic>;
        print('newsListData: $newsListData');
        return newsListData.map((json) => NewsArticle.fromJson(json as Map<String, dynamic>)).toList();
      }

      throw Exception();
    } catch (e) {
      await GeneralFunctions.toastMessage('선택한 카테고리 정보를 가져오는 데 실패했습니다.');
      throw Exception();
    }
  }
}