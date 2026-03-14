import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../config/api_config.dart';
import '../models/ad_response.dart';
import 'http_service.dart';

/// 广告服务
/// 处理广告相关的API请求
class AdService {
  late final Dio _dio;

  AdService() {
    _dio = HttpService.createDio(ApiConfig.adBaseUrl);
  }

  /// 获取启动页广告
  /// POST /api/ad/splash
  Future<AdResponse?> getSplashAd() async {
    try {
      final response = await HttpService.post(
        _dio,
        ApiConfig.adSplashPath,
        data: {}, // 空body的POST请求
      );

      if (response.statusCode == 200 && response.data != null) {
        return AdResponse.fromJson(response.data);
      }
      return null;
    } on DioException catch (e) {
      // 网络请求失败，静默处理
      debugPrint('获取广告失败: ${e.message}');
      return null;
    } catch (e) {
      // 其他异常，静默处理
      debugPrint('获取广告异常: $e');
      return null;
    }
  }
}
