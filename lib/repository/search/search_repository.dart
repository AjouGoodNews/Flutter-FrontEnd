import 'package:dio/dio.dart';
import 'package:goodnews/model/news/news_article.dart';
import 'package:goodnews/model/news/news_article_detail.dart';

import 'package:goodnews/service/dio/dio_service.dart';
import 'package:goodnews/service/general/general_functions.dart';

class SearchRepository {
  final Dio _dio = DioService().dio;

  Future<List<NewsArticle>> getNewsByQuery(String query) async {
    try {
      final response = await _dio.get(
        '/api/search/0?query=$query',
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
      await GeneralFunctions.toastMessage('검색한 뉴스 정보를 가져오는 데 실패했어요');
      throw Exception();
    }
  }
}