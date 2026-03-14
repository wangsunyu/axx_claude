# 开发环境配置指南

本文档说明如何配置Flutter多平台开发环境。

## 基础要求

### Flutter SDK
- **版本**: 3.x 或更高
- **安装**:
  ```bash
  # macOS
  git clone https://github.com/flutter/flutter.git -b stable
  export PATH="$PATH:`pwd`/flutter/bin"

  # 中国大陆用户使用镜像
  export PUB_HOSTED_URL=https://pub.flutter-io.cn
  export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
  ```

- **验证**:
  ```bash
  flutter doctor
  ```

## iOS开发环境

### 必需工具
1. **Xcode** (16.0+)
   - 从Mac App Store安装
   - 安装Command Line Tools:
     ```bash
     xcode-select --install
     ```

2. **CocoaPods**
   ```bash
   sudo gem install cocoapods
   ```

### 配置步骤
1. 打开Xcode，同意许可协议
2. 配置iOS模拟器或连接真机
3. 在项目中运行:
   ```bash
   cd ios
   pod install
   cd ..
   flutter run -d ios
   ```

### 常见问题
- **签名问题**: 在Xcode中配置开发团队
- **模拟器问题**: 确保已安装iOS模拟器

## Android开发环境

### 必需工具
1. **Android Studio** (最新版本)
   - 下载: https://developer.android.com/studio
   - 安装Android SDK
   - 安装Android SDK Command-line Tools

2. **Java Development Kit (JDK)**
   - 推荐JDK 17或更高版本

### 配置步骤
1. 安装Android Studio
2. 打开SDK Manager，安装:
   - Android SDK Platform (API 21+)
   - Android SDK Build-Tools
   - Android SDK Platform-Tools
   - Android SDK Command-line Tools

3. 配置环境变量:
   ```bash
   export ANDROID_HOME=$HOME/Library/Android/sdk
   export PATH=$PATH:$ANDROID_HOME/tools
   export PATH=$PATH:$ANDROID_HOME/platform-tools
   ```

4. 接受Android许可:
   ```bash
   flutter doctor --android-licenses
   ```

5. 运行项目:
   ```bash
   flutter run -d android
   ```

### 常见问题
- **Gradle问题**: 确保网络连接正常，或配置Gradle镜像
- **SDK问题**: 运行 `flutter doctor` 检查缺失的组件

## 鸿蒙开发环境

### 必需工具
1. **DevEco Studio**
   - 下载: https://developer.harmonyos.com/cn/develop/deveco-studio
   - 安装HarmonyOS SDK

2. **flutter_ohos插件**
   - 在pubspec.yaml中添加依赖

### 配置步骤
1. 安装DevEco Studio
2. 配置HarmonyOS SDK
3. 创建ohos目录结构
4. 配置Platform Channel桥接
5. 在DevEco Studio中打开ohos目录

### 注意事项
- 鸿蒙平台支持需要额外配置
- 需要华为开发者账号
- 部分Flutter插件可能不支持鸿蒙

## 验证环境

运行以下命令检查所有平台的配置状态:

```bash
flutter doctor -v
```

确保所有必需的工具都显示为 ✓ (绿色勾号)。

## 推荐的IDE

### Visual Studio Code
- 安装Flutter和Dart插件
- 轻量级，启动快速

### Android Studio / IntelliJ IDEA
- 完整的Flutter开发支持
- 强大的调试工具

### Xcode
- iOS开发必需
- 用于iOS特定的调试和配置

## 依赖管理

### 获取依赖
```bash
flutter pub get
```

### 更新依赖
```bash
flutter pub upgrade
```

### 清理缓存
```bash
flutter clean
flutter pub get
```

## 构建配置

### 开发模式
```bash
flutter run
```

### 发布模式
```bash
# iOS
flutter build ios --release

# Android
flutter build apk --release
flutter build appbundle --release
```

## 故障排除

### Flutter Doctor问题
如果 `flutter doctor` 显示问题:
1. 仔细阅读错误信息
2. 按照提示安装缺失的工具
3. 重新运行 `flutter doctor`

### 网络问题
中国大陆用户建议配置镜像:
```bash
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
```

### 版本冲突
如果遇到依赖版本冲突:
```bash
flutter pub upgrade --major-versions
```
