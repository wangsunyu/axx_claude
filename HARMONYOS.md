# 鸿蒙平台集成指南

本文档说明如何将Flutter项目集成到鸿蒙（HarmonyOS）平台。

## 前置要求

### 必需工具
1. **DevEco Studio** (最新版本)
   - 下载地址: https://developer.harmonyos.com/cn/develop/deveco-studio
   - 安装HarmonyOS SDK (API 9+)

2. **华为开发者账号**
   - 注册地址: https://developer.huawei.com/consumer/cn/

3. **Flutter SDK** (已安装)

## 集成步骤

### 1. 安装flutter_ohos插件

目前鸿蒙平台的Flutter支持主要通过社区插件实现。需要在 `pubspec.yaml` 中添加：

```yaml
dependencies:
  flutter_ohos: ^x.x.x  # 查看最新版本
```

**注意**: flutter_ohos插件可能需要从特定渠道获取，请参考官方文档。

### 2. 配置Platform Channel

创建Flutter和鸿蒙原生层的通信桥接：

#### Flutter端 (lib/platform_channel.dart)

```dart
import 'package:flutter/services.dart';

class PlatformChannel {
  static const platform = MethodChannel('com.example.app/channel');

  static Future<String> getPlatformVersion() async {
    try {
      final String version = await platform.invokeMethod('getPlatformVersion');
      return version;
    } on PlatformException catch (e) {
      return "Failed to get platform version: '${e.message}'.";
    }
  }
}
```

#### 鸿蒙端 (ohos/entry/src/main/ets/entryability/EntryAbility.ts)

需要实现MethodChannel的处理逻辑，响应Flutter端的调用。

### 3. 在DevEco Studio中打开项目

1. 启动DevEco Studio
2. 选择 "Open" 打开项目
3. 选择 `ohos/` 目录
4. 等待项目索引完成
5. 配置HarmonyOS SDK路径

### 4. 配置应用签名

1. 在DevEco Studio中打开 File > Project Structure
2. 配置Signing Configs
3. 添加开发者证书和Profile文件

### 5. 构建和运行

#### 在DevEco Studio中
1. 连接鸿蒙设备或启动模拟器
2. 点击 Run 按钮
3. 选择目标设备

#### 命令行构建
```bash
cd ohos
# 使用hvigor构建
./hvigorw assembleHap
```

构建产物位于: `ohos/entry/build/outputs/default/entry-default-signed.hap`

## 目录结构说明

```
ohos/
├── build-profile.json5           # 应用级构建配置
├── hvigorfile.ts                 # Hvigor构建工具配置
├── entry/                        # 入口模块
│   ├── hvigorfile.ts            # 模块级构建配置
│   └── src/
│       └── main/
│           ├── ets/             # ArkTS源代码
│           │   ├── entryability/
│           │   │   └── EntryAbility.ts  # 应用入口
│           │   └── pages/
│           │       └── Index.ets        # 主页面
│           ├── resources/       # 资源文件
│           │   └── base/
│           │       ├── element/
│           │       │   ├── color.json   # 颜色资源
│           │       │   └── string.json  # 字符串资源
│           │       ├── media/           # 图片资源
│           │       └── profile/
│           │           └── main_pages.json  # 页面路由配置
│           └── module.json5     # 模块配置文件
```

## 常见问题

### Q: flutter_ohos插件在哪里获取？
A: 目前鸿蒙的Flutter支持还在发展中，可以关注以下资源：
- OpenHarmony官方文档
- Flutter社区的鸿蒙适配项目
- 华为开发者论坛

### Q: 如何调试鸿蒙应用？
A:
1. 在DevEco Studio中设置断点
2. 使用Debug模式运行
3. 查看HiLog日志输出

### Q: 部分Flutter插件不支持鸿蒙怎么办？
A:
1. 寻找支持鸿蒙的替代插件
2. 使用Platform Channel自行实现原生功能
3. 使用条件编译，在鸿蒙平台提供降级方案

### Q: 如何发布到华为应用市场？
A:
1. 注册华为开发者账号
2. 在AppGallery Connect创建应用
3. 配置应用信息和签名
4. 上传HAP包
5. 提交审核

## 参考资源

- [HarmonyOS开发者文档](https://developer.harmonyos.com/cn/documentation)
- [DevEco Studio使用指南](https://developer.harmonyos.com/cn/develop/deveco-studio)
- [ArkTS语言参考](https://developer.harmonyos.com/cn/docs/documentation/doc-guides-V3/arkts-get-started-0000001504769321-V3)
- [Flutter官方文档](https://flutter.dev/docs)

## 下一步

1. 安装DevEco Studio
2. 配置HarmonyOS SDK
3. 在DevEco Studio中打开ohos目录
4. 添加flutter_ohos插件依赖
5. 实现Platform Channel桥接
6. 测试应用运行

## 注意事项

- 鸿蒙平台的Flutter支持仍在发展中
- 某些Flutter特性可能不完全支持
- 建议先在iOS/Android平台完成核心功能开发
- 鸿蒙平台作为额外的目标平台逐步适配
