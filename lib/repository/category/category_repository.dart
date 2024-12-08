import 'package:dio/dio.dart';
import 'package:goodnews/model/news/news_article.dart';
import 'package:goodnews/model/news/news_article_detail.dart';

import 'package:goodnews/service/dio/dio_service.dart';
import 'package:goodnews/service/general/general_functions.dart';

class CategoryRepository {
  final Dio _dio = DioService().dio;

  Future<List<NewsArticle>> getNewsByCategory(String category) async {
    try {
      final response = await _dio.get(
        '/api/category/0?category=$category',
      );

      if (response.statusCode != 200) {
        throw Exception();
      }

      final Map<String, dynamic> jsonData = response.data;
      print('jsonData: $jsonData');
      List<dynamic> newsListData = jsonData['newsList'] as List<dynamic>;
      print('newsListData: $newsListData');
      return newsListData.map((json) => NewsArticle.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      await GeneralFunctions.toastMessage('선택한 카테고리 정보를 가져오는 데 실패했어요');
      throw Exception();
    }
  }

  Future<NewsArticleDetail> getNewsDetailByNewsId(int newsId) async {
    try {
      final response = await _dio.get(
        '/api/category/content/$newsId',
      );

      if (response.statusCode != 200) {
        throw Exception();
      }

      final Map<String, dynamic> jsonData = response.data;
      print('jsonData: $jsonData');
      return NewsArticleDetail.fromJson(jsonData);
    } catch (e) {
      await GeneralFunctions.toastMessage('뉴스 본문을 가져오는 데 실패했어요');
      throw Exception();
    }
  }
}