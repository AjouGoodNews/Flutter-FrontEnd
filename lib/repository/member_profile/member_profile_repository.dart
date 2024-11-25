import 'package:dio/dio.dart';

import 'package:goodnews/service/dio/dio_service.dart';
import 'package:goodnews/service/general/general_functions.dart';
import 'package:goodnews/service/logger/logger.dart';

// categories : POLITICS, ECONOMY, WORLD, TECH, LABOR, ENVIRONMENT, HUMAN_RIGHTS, CULTURE, LIFE
class MemberProfileRepository {
  final Dio _dio = DioService().dio;

  Future<void> signup(String gender, List<String> categories) async {
    try {
      logger.i('회원가입 시도');

      final response = await _dio.post(
        '/api/profile/new',
        data: {
          'gender': gender,
          'categories': categories,
        },
      );

      if (response.statusCode == 200) {
        return;
      }

      throw Exception();
    } catch (e) {
      await GeneralFunctions.toastMessage('회원가입에 실패했습니다.');
      logger.e('회원가입 실패', error: e);

      throw Exception();
    }
  }
}