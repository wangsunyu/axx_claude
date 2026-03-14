# Flutter多平台项目

这是一个支持iOS、Android和鸿蒙（HarmonyOS）三个平台的Flutter项目。

## 项目结构

```
axx_flutter_multiplatform/
├── lib/              # Flutter共享代码
├── ios/              # iOS原生代码
├── android/          # Android原生代码
├── ohos/             # 鸿蒙原生代码
├── assets/           # 资源文件
├── pubspec.yaml      # Flutter依赖配置
├── build.sh          # 统一构建脚本
├── README.md         # 项目说明
├── ENVIRONMENT.md    # 环境配置指南
└── HARMONYOS.md      # 鸿蒙平台集成指南
```

## 环境要求

- Flutter SDK 3.x+
- Dart 3.x+
- Xcode 12.0+ (iOS开发)
- Android Studio / Android SDK (Android开发)
- DevEco Studio (鸿蒙开发)

## 功能列表

- [广告启动页](docs/features/create-ad-page/changelog.md) - 全屏广告、倒计时、环境切换

## 快速开始

### iOS平台

```bash
flutter run -d ios
```

或在Xcode中打开 `ios/Runner.xcworkspace` 进行开发。

### Android平台

```bash
# 构建APK
flutter build apk

# 构建App Bundle
flutter build appbundle

# 运行
flutter run -d android
```

### 鸿蒙平台

鸿蒙平台需要使用DevEco Studio进行开发和构建。

**开发步骤：**
1. 安装DevEco Studio
2. 在DevEco Studio中打开 `ohos/` 目录
3. 配置HarmonyOS SDK
4. 运行或构建HAP包

**详细说明：** 请查看 [HARMONYOS.md](./HARMONYOS.md)

## 统一构建脚本

使用 `build.sh` 脚本可以快速构建各平台：

```bash
# 构建所有平台
./build.sh all release

# 只构建iOS
./build.sh ios release

# 只构建Android
./build.sh android debug

# 查看帮助
./build.sh --help
```

## 构建

### iOS构建

```bash
flutter build ios --release
```

### Android构建

```bash
# APK
flutter build apk --release

# App Bundle (推荐用于Google Play)
flutter build appbundle --release
```

## 开发

运行项目：

```bash
flutter run
```

热重载：按 `r` 键
热重启：按 `R` 键
退出：按 `q` 键

## 依赖管理

安装依赖：

```bash
flutter pub get
```

更新依赖：

```bash
flutter pub upgrade
```

## 测试

运行测试：

```bash
flutter test
```

## 问题排查

检查开发环境：

```bash
flutter doctor
```

清理构建缓存：

```bash
flutter clean
flutter pub get
```
