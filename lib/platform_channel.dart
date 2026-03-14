import 'package:flutter/services.dart';

/// Platform Channel for communicating with native platforms
/// 用于与原生平台通信的Platform Channel
class PlatformChannel {
  static const MethodChannel _channel = MethodChannel('com.example.axx_flutter_multiplatform/platform');

  /// Get platform version
  /// 获取平台版本信息
  static Future<String> getPlatformVersion() async {
    try {
      final String version = await _channel.invokeMethod('getPlatformVersion');
      return version;
    } on PlatformException catch (e) {
      return "Failed to get platform version: '${e.message}'.";
    }
  }

  /// Get platform name
  /// 获取平台名称
  static Future<String> getPlatformName() async {
    try {
      final String name = await _channel.invokeMethod('getPlatformName');
      return name;
    } on PlatformException catch (e) {
      return "Failed to get platform name: '${e.message}'.";
    }
  }

  /// Example method for custom platform-specific functionality
  /// 自定义平台特定功能的示例方法
  static Future<dynamic> invokeMethod(String method, [dynamic arguments]) async {
    try {
      return await _channel.invokeMethod(method, arguments);
    } on PlatformException catch (e) {
      throw Exception("Platform method '$method' failed: ${e.message}");
    }
  }
}
