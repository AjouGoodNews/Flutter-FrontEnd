import 'package:dio/dio.dart';

import 'package:goodnews/service/dio/dio_service.dart';
import 'package:goodnews/service/general/general_functions.dart';
import 'package:goodnews/service/logger/logger.dart';

class HomeRepository {
  final Dio _dio = DioService().dio;

  Future<List<String>> getUserCategory() async {
    try {
      final response = await _dio.get(
        '/api/home',
      );

      if (response.statusCode == 200) {
        return List<String>.from(response.data); // 응답 데이터를 리스트로 변환하여 반환
      }

      throw Exception();
    } catch (e) {
      await GeneralFunctions.toastMessage('선택한 카테고리 정보를 가져오는 데 실패했습니다.');
      throw Exception();
    }
  }
}