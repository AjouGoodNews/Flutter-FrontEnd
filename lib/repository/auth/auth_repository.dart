import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:goodnews/service/dio/dio_service.dart';
import 'package:goodnews/service/general/general_functions.dart';
import 'package:goodnews/service/logger/logger.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  final Dio _dio = DioService().dio;

  Future<Map<String, String>> logIn(String googleAccessToken) async {
    try {
      logger.i('토큰 발급 시도');

      // final response = await http.get(
      //   Uri.parse('http://localhost:8080/api/login/success'),
      //   headers: {
      //     'Authorization': 'Bearer ${googleAccessToken}',
      //   },
      // );
      // logger.i(response);
      //
      // if (response.statusCode == 200) {
      //   final responseData = json.decode(response.body);
      //   bool isProfileComplete = responseData['isProfileComplete'];
      //
      //   // 프로필 상태에 따라 UI 업데이트
      //   if (isProfileComplete) {
      //     print('프로필이 완성되었습니다.');
      //   } else {
      //     print('프로필이 완성되지 않았습니다.');
      //   }
      // } else {
      //   print('로그인 실패: ${response.statusCode}');
      // }

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