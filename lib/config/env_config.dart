/// 环境配置
/// 通过编译时参数 --dart-define=ENV=prod 切换环境
enum Environment { dev, prod }

class EnvConfig {
  static const String _env = String.fromEnvironment('ENV', defaultValue: 'dev');

  static Environment get current =>
      _env == 'prod' ? Environment.prod : Environment.dev;

  static bool get isDev => current == Environment.dev;
  static bool get isProd => current == Environment.prod;

  static String get envName => _env;
}
