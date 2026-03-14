import 'package:dio/dio.dart';

/// HTTP服务基础类
/// 封装Dio配置和通用请求方法
class HttpService {
  /// 创建Dio实例
  static Dio createDio(String baseUrl) {
    final dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
      },
    ));

    // 添加拦截器（可选）
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));

    return dio;
  }

  /// POST请求
  static Future<Response> post(
    Dio dio,
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
      );
    } catch (e) {
      rethrow;
    }
  }

  /// GET请求
  static Future<Response> get(
    Dio dio,
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await dio.get(
        path,
        queryParameters: queryParameters,
      );
    } catch (e) {
      rethrow;
    }
  }
}
