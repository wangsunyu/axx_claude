import 'env_config.dart';

/// API配置
/// 管理所有服务的基础地址
class ApiConfig {
  // 广告服务基础地址
  static String get adBaseUrl => EnvConfig.isDev
      ? 'https://dev-ad-api.example.com'
      : 'https://ad-api.example.com';

  // 用户服务基础地址
  static String get userBaseUrl => EnvConfig.isDev
      ? 'https://dev-user-api.example.com'
      : 'https://user-api.example.com';

  // 内容服务基础地址
  static String get contentBaseUrl => EnvConfig.isDev
      ? 'https://dev-content-api.example.com'
      : 'https://content-api.example.com';

  // 广告接口路径
  static const String adSplashPath = '/api/ad/splash';

  // 完整广告接口URL
  static String get adSplashUrl => '$adBaseUrl$adSplashPath';
}
