import 'package:flutter_test/flutter_test.dart';
import 'package:axx_flutter_multiplatform/config/api_config.dart';

void main() {
  group('ApiConfig', () {
    test('广告服务基础地址应该包含 dev 前缀', () {
      expect(ApiConfig.adBaseUrl, contains('dev'));
    });

    test('广告接口路径应该正确', () {
      expect(ApiConfig.adSplashPath, equals('/api/ad/splash'));
    });

    test('完整广告接口 URL 应该正确拼接', () {
      expect(ApiConfig.adSplashUrl, endsWith('/api/ad/splash'));
      expect(ApiConfig.adSplashUrl, startsWith('https://'));
    });

    test('所有服务基础地址应该是 HTTPS', () {
      expect(ApiConfig.adBaseUrl, startsWith('https://'));
      expect(ApiConfig.userBaseUrl, startsWith('https://'));
      expect(ApiConfig.contentBaseUrl, startsWith('https://'));
    });
  });
}
