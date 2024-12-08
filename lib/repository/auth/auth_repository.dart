import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:goodnews/service/dio/dio_service.dart';
import 'package:goodnews/service/general/general_functions.dart';
import 'package:goodnews/service/logger/logger.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  final Dio _dio = DioService().dio;

  Future<Map<String, dynamic>> logIn(String googleIdToken) async {
    try {
      logger.i('토큰 발급 시도');

      final response = await _dio.post(
        '/api/auth/google',
        data: {
          'idToken': googleIdToken,
        },
      );

      if (response.statusCode != 200) {
        throw Exception();
      }

      return {
        'accessToken': response.data['token'],
        'isProfileComplete': response.data['profileComplete'],
      };
      // return {
      //   'accessToken': googleAccessToken,
      //   'refreshToken': googleAccessToken,
      // };
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