import 'package:flutter_test/flutter_test.dart';
import 'package:axx_flutter_multiplatform/config/env_config.dart';

void main() {
  group('EnvConfig', () {
    test('默认环境应该是 dev', () {
      expect(EnvConfig.isDev, isTrue);
      expect(EnvConfig.isProd, isFalse);
    });

    test('环境名称应该正确', () {
      expect(EnvConfig.envName, equals('dev'));
    });

    test('current 应该返回正确的枚举值', () {
      expect(EnvConfig.current, equals(Environment.dev));
    });
  });
}
