import 'package:dio/dio.dart';

import 'package:goodnews/service/dio/dio_service.dart';
import 'package:goodnews/service/general/general_functions.dart';
import 'package:goodnews/service/logger/logger.dart';

class AuthRepository {
  final Dio _dio = DioService().dio;

  Future<Map<String, String>> logIn(String googleAccessToken) async {
    try {
      logger.i('토큰 발급 시도');

      return {
        'accessToken': googleAccessToken,
        'refreshToken': googleAccessToken,
      };

      // final response = await _dio.post(
      //   '/api/login/social',
      //   data: {
      //     'accessToken': googleAccessToken,
      //   },
      // );
      //
      // if (response.statusCode == 200) {
      //   return {
      //     'accessToken': response.data['accessToken'],
      //     'refreshToken': response.data['refreshToken'],
      //   };
      // }
      //
      // throw Exception();
    } catch (e) {
      await GeneralFunctions.toastMessage('로그인에 실패했습니다.');
      logger.e('토큰 발급 실패', error: e);

      throw Exception();
    }
  }

  Future<void> logOut(String refreshToken) async {
    try {
      logger.i('토큰 삭제 시도');

      await _dio.post(
        '/auth/logout',
        data: {
          'refreshToken': refreshToken,
        },
      );
    } catch (e) {
      logger.e('토큰 삭제 실패', error: e);
      throw Exception();
    }
  }
}