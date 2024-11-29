import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../utils/logger.dart';
import 'dio_interceptor.dart';

class DioService {
  final Dio dio;

  DioService._internal(this.dio);

  static final DioService _instance = DioService._internal(
    Dio(
      BaseOptions(
        baseUrl: dotenv.env['SERVER_BASE_URL']!,
        contentType: 'application/json',
      ),
    ),
  );

  factory DioService() {
    _instance._addInterceptors();
    return _instance;
  }

  void _addInterceptors() {
    dio.interceptors.clear();
    dio.interceptors.add(DioInterceptor(dio));

    // 로그 출력
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        logger.i('요청 시작: ${options.method} ${options.uri}');
        logger.i('요청 헤더: ${options.headers}');
        logger.i('요청 데이터: ${options.data}');
        return handler.next(options); // continue
      },
      onResponse: (response, handler) {
        logger.i('응답 수신: ${response.statusCode} ${response.data}');
        return handler.next(response); // continue
      },
      onError: (DioError e, handler) {
        logger.e('요청 에러: ${e.message}');
        if (e.response != null) {
          logger.e('응답 상태 코드: ${e.response?.statusCode}');
          logger.e('응답 데이터: ${e.response?.data}');
        }
        return handler.next(e); // continue
      },
    ));
  }

  Dio getDio() => dio;
}