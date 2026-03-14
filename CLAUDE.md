# Flutter 多平台项目

这是一个支持 iOS、Android 和 HarmonyOS 三个平台的 Flutter 应用。

## 项目概述

- **项目名称**: axx_flutter_multiplatform
- **Flutter 版本**: 3.41.4 (stable)
- **Dart 版本**: 3.11.1
- **支持平台**: iOS, Android, HarmonyOS
- **原始项目**: 基于 iOS Objective-C 项目迁移
  - **iOS 原项目路径**: `/Users/wsy/Desktop/code/安小信/安小信iOS/SCPlatformTeacher`
  - **迁移目标**: 将 iOS 原生项目迁移为 Flutter 多平台应用，支持 iOS、Android、HarmonyOS 三端

## 开发原则

### 参考原项目
- **所有功能实现必须参考 iOS 原项目**：`/Users/wsy/Desktop/code/安小信/安小信iOS/SCPlatformTeacher`
- 查看原项目的 UI 设计、交互逻辑、业务流程
- 图片资源从原项目的 `Assets.xcassets` 中获取
- 保持与原项目一致的用户体验

### 多平台适配
- 使用 Flutter 的跨平台特性，一套代码适配三端
- 不要硬编码 iOS 的固定比例，使用 Flutter 的响应式布局
- 使用 MediaQuery、LayoutBuilder 等工具进行屏幕适配
- 遵循 Material Design 和各平台的设计规范

## 项目结构

```
lib/
├── config/          # 配置文件（环境、API地址）
├── models/          # 数据模型
├── services/        # 服务层（网络请求、业务逻辑）
├── pages/           # 页面
├── widgets/         # 可复用组件
└── main.dart        # 应用入口
```

## 开发规范

### 代码风格
- 遵循 Flutter 官方代码规范
- 使用 `flutter_lints` 进行代码检查
- 避免使用 `print`，使用 `debugPrint` 代替
- 使用新的 API（如 `withValues` 而不是 `withOpacity`）

### 命名规范
- 文件名：小写下划线分隔（snake_case）
- 类名：大驼峰（PascalCase）
- 变量/方法：小驼峰（camelCase）
- 常量：大写下划线分隔（UPPER_SNAKE_CASE）

### 目录组织
- `config/`: 全局配置（环境、API、常量）
- `models/`: 数据模型，包含 fromJson/toJson
- `services/`: 业务逻辑和 API 调用
- `pages/`: 完整页面组件
- `widgets/`: 可复用的 UI 组件

### 图片资源规范
- **重要**：项目中提供的所有图片资源都是 iOS 的 2 倍图（@2x）
- 在 Flutter 中使用图片时，需要正确处理图片分辨率
- 建议在 `assets/images/` 目录下按照 Flutter 规范组织：
  - `image.png` - 1x 图片
  - `2.0x/image.png` - 2x 图片
  - `3.0x/image.png` - 3x 图片
- 如果只有 @2x 图片，应将其放在 `2.0x/` 子目录中，或在代码中使用时指定 scale 参数

## 环境配置

### 环境切换
项目支持测试和生产环境，通过编译时参数切换：

```bash
# 测试环境（默认）
flutter run --dart-define=ENV=dev

# 生产环境
flutter run --dart-define=ENV=prod
```

### API 配置
所有 API 基础地址在 `lib/config/api_config.dart` 中配置：
- `adBaseUrl`: 广告服务
- `userBaseUrl`: 用户服务
- `contentBaseUrl`: 内容服务

## 网络请求

### 使用 dio 进行网络请求
- 基础封装在 `lib/services/http_service.dart`
- 具体业务服务继承基础服务
- 统一错误处理和超时配置（10秒）

### 请求示例
```dart
final response = await HttpService.post(
  dio,
  '/api/path',
  data: {'key': 'value'},
);
```

## 启动流程

当前启动流程：
1. 应用启动 → 广告页（AdSplashPage）
2. 5秒倒计时或点击跳过 → 主页（MyHomePage）

## 平台特定说明

### iOS
- 最低版本：iOS 12.0
- 使用 CocoaPods 管理依赖
- 在 Xcode 中配置签名

### Android
- 最低 SDK：21 (Android 5.0)
- 使用 Gradle 构建
- Kotlin 支持已启用

### HarmonyOS
- 基础结构已创建在 `ohos/` 目录
- 需要 DevEco Studio 进行开发
- 详见 `HARMONYOS.md`

## 构建命令

```bash
# iOS
flutter build ios --release

# Android APK
flutter build apk --release

# Android App Bundle
flutter build appbundle --release

# 使用统一构建脚本
./build.sh all release
```

## 常用命令

```bash
# 安装依赖
flutter pub get

# 代码检查
flutter analyze

# 格式化代码
flutter format lib/

# 清理缓存
flutter clean

# 检查环境
flutter doctor
```

## 注意事项

### 开发时
- 修改代码后使用热重载（r）而不是热重启（R）
- 添加新依赖后运行 `flutter pub get`
- 提交前运行 `flutter analyze` 确保无错误

### 发布时
- 生产环境必须使用 `--dart-define=ENV=prod`
- 更新版本号在 `pubspec.yaml`
- iOS 需要配置证书和 Profile
- Android 需要配置签名

## 文档

- `README.md`: 项目使用指南
- `ENVIRONMENT.md`: 环境配置详细说明
- `HARMONYOS.md`: HarmonyOS 平台集成指南

## 已实现功能

| 功能 | AI 上下文 | 开发者文档 |
|------|-----------|------------|
| 广告启动页 | [ai-context](docs/features/create-ad-page/ai-context.md) | [changelog](docs/features/create-ad-page/changelog.md) |

## 待开发功能

根据业务需求逐步添加：
- 用户认证和授权
- 数据持久化
- 状态管理（如需要可使用 Provider/Riverpod）
- 更多页面和功能模块
